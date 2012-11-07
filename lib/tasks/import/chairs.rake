namespace :import do
  desc 'Import chairs'
  task :chairs => :environment do
    puts 'Import chairs'
    response = Curl.get('http://localhost:3001/api/chairs')
    chairs_attributes = JSON.parse(response.body_str).map { |hash| Hashie::Mash.new(hash) }
    progress_bar = ProgressBar.new(chairs_attributes.size)

    chairs_attributes.each do |chair_attributes|
      chair = Chair.find_or_initialize_by_abbr(chair_attributes.abbr)
      chair.update_attributes!(abbr: chair_attributes.abbr,
                               chief: chair_attributes.chief,
                               faculty: chair_attributes.faculty,
                               title: chair_attributes.title)
      progress_bar.increment!
    end
  end
end
