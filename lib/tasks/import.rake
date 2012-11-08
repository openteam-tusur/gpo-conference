namespace :import do
  desc 'Import chairs'
  task :chairs => :environment do
    puts 'Import chairs'

    response          = Curl.get("#{Settings['gpo.url']}/api/chairs")
    chairs_attributes = JSON.parse(response.body_str).map { |hash| Hashie::Mash.new(hash) }
    progress_bar      = ProgressBar.new(chairs_attributes.size)

    chairs_attributes.each do |chair_attributes|
      chair = Chair.find_or_initialize_by_gpo_id(chair_attributes.id)
      chair.update_attributes!(abbr: chair_attributes.abbr,
                               chief: chair_attributes.chief,
                               faculty: chair_attributes.faculty,
                               title: chair_attributes.title)
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
      theme.update_attributes!(name: theme_attributes.name)
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

      unless theme
        puts "Project '#{project_attributes.title}' with id #{project_attributes.id} does not have theme"
        next
      end

      project.update_attributes!(analysis: project_attributes.analysis,
                                 expected_results: project_attributes.expected_results,
                                 features: project_attributes.features,
                                 forecast: project_attributes.forecast,
                                 funds_required: project_attributes.funds_required,
                                 funds_sources: project_attributes.funds_sources,
                                 goal: project.goal,
                                 novelty: project.novelty,
                                 purpose: project_attributes.novelty,
                                 release_cost: project_attributes.release_cost,
                                 source_data: project_attributes.source_data,
                                 stakeholders: project_attributes.stakeholders,
                                 title: project_attributes.title,
                                 theme_id: theme.id)
      progress_bar.increment!
    end
  end

  desc 'Import participants'
  task :participants => :environment do
    puts 'Import participants'

    response                = Curl.get("#{Settings['gpo.url']}/api/participants")
    participants_attributes = JSON.parse(response.body_str).map { |hash| Hashie::Mash.new(hash) }
    progress_bar            = ProgressBar.new(participants_attributes.size)

    participants_attributes.each do |participant_attributes|
      participant = Participant.find_or_initialize_by_gpo_id(participant_attributes.id)
      project = Project.find_by_gpo_id(participant_attributes.project_id)

      unless project
        puts "It seems project with id #{participant_attributes.project_id} was not imported"
        next
      end

      participant.update_attributes!(course: participant_attributes.course,
                                     edu_group: participant_attributes.edu_group,
                                     email: participant_attributes.email,
                                     first_name: participant_attributes.first_name,
                                     last_name: participant_attributes.last_name,
                                     mid_name: participant_attributes.mid_name,
                                     project_id: project.id)
      progress_bar.increment!
    end
  end

  desc 'Import managers'
  task :managers => :environment do
    puts 'Import managers'

    response            = Curl.get("#{Settings['gpo.url']}/api/managers")
    managers_attributes = JSON.parse(response.body_str).map { |hash| Hashie::Mash.new(hash) }
    progress_bar        = ProgressBar.new(managers_attributes.size)

    managers_attributes.each do |manager_attributes|
      manager = Manager.find_or_initialize_by_gpo_id(manager_attributes.id)
      project = Project.find_by_gpo_id(manager_attributes.project_id)

      unless project
        puts "It seems project with id #{manager_attributes.project_id} was not imported"
        next
      end

      manager.update_attributes!(email: manager_attributes.email,
                                 first_name: manager_attributes.first_name,
                                 last_name: manager_attributes.last_name,
                                 mid_name: manager_attributes.mid_name,
                                 project_id: project.id)
      progress_bar.increment!
    end
  end

  desc 'Import all'
  task :all => [:chairs, :themes, :projects, :participants, :managers] do
  end
end
