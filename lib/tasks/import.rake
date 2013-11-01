# encoding: utf-8

namespace :import do
  desc 'Import chairs'
  task :chairs => :environment do
    puts 'Import chairs'

    response          = Curl.get("#{Settings['gpo.url']}/api/chairs")
    chairs_attributes = JSON.parse(response.body_str).map { |hash| Hashie::Mash.new(hash) }
    progress_bar      = ProgressBar.new(chairs_attributes.size)

    chairs_attributes.each do |chair_attributes|
      chair = Chair.find_or_initialize_by_gpo_id(chair_attributes.id)
      chair.update_attributes!(abbr: chair_attributes.abbr.squish,
                               chief: chair_attributes.chief.squish,
                               faculty: chair_attributes.faculty.try(:squish),
                               title: chair_attributes.title.squish)
      progress_bar.increment!
    end
  end

  desc 'Import themes'
  task :themes => :environment do
    puts 'Import themes'

    response          = Curl.get("#{Settings['gpo.url']}/api/themes")
    themes_attributes = JSON.parse(response.body_str).map { |hash| Hashie::Mash.new(hash) }
    progress_bar      = ProgressBar.new(themes_attributes.size)

    if (conference = Conference.find_by_year(Time.zone.today.year.to_s)).present?
      themes_attributes.each do |theme_attribute|
        Theme.find_or_create_by_conference_id_and_gpo_id_and_name(
          :conference_id => conference.id,
          :gpo_id        => theme_attribute.id,
          :name          => theme_attribute.name.squish
        )
        progress_bar.increment!
      end
    else
      puts 'Не создана конференция для текущего года'
    end
  end

  desc 'Import projects'
  task :projects => :environment do
    puts 'Import projects'

    response            = Curl.get("#{Settings['gpo.url']}/api/projects")
    projects_attributes = JSON.parse(response.body_str).map { |hash| Hashie::Mash.new(hash) }
    progress_bar        = ProgressBar.new(projects_attributes.size)

    if (conference = Conference.find_by_year(Time.zone.today.year.to_s)).present?
      projects_attributes.each do |project_attribute|
        theme   = Theme.find_by_conference_id_and_gpo_id(conference.id, project_attribute.theme_id)

        if theme
          project = Project.find_or_initialize_by_gpo_id_and_theme_id(project_attribute.id, theme.id)
          chair   = Chair.find_by_gpo_id(project_attribute.chair_id)
          project.update_attributes!(chair_id: chair.id,
                                     title: project_attribute.title.squish,
                                     cipher: project_attribute.cipher.squish)
        else
          puts "Project with id #{project_attribute.id} does not have theme"
        end

        progress_bar.increment!
      end
    else
      puts 'Не создана конференция для текущего года'
    end
  end

  desc 'Import all'
  task :all => [:chairs, :themes, :projects] do
  end
end
