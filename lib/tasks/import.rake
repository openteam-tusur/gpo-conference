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
                               faculty: chair_attributes.faculty.squish,
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

    themes_attributes.each do |theme_attributes|
      theme = Theme.find_or_initialize_by_gpo_id(theme_attributes.id)
      theme.update_attributes!(name: theme_attributes.name.squish)
      progress_bar.increment!
    end
  end

  desc 'Import projects'
  task :projects => :environment do
    puts 'Import projects'

    response            = Curl.get("#{Settings['gpo.url']}/api/projects")
    projects_attributes = JSON.parse(response.body_str).map { |hash| Hashie::Mash.new(hash) }
    progress_bar        = ProgressBar.new(projects_attributes.size)

    projects_attributes.each do |project_attributes|
      project = Project.find_or_initialize_by_gpo_id(project_attributes.id)
      theme = Theme.find_by_gpo_id(project_attributes.theme_id)
      chair = Chair.find_by_gpo_id(project_attributes.chair_id)

      unless theme
        puts "Project with id #{project_attributes.id} does not have theme"
        next
      end

      project.update_attributes!(chair_id: chair.id,
                                 title: project_attributes.title.squish,
                                 theme_id: theme.id,
                                 cipher: project_attributes.cipher.squish)
      progress_bar.increment!
    end
  end

  desc 'Import all'
  task :all => [:chairs, :themes, :projects] do
  end
end
