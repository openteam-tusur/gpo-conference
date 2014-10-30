require 'csv'
desc 'Migrate user ids'
task :migrate => :environment do
  content = CSV.open('users.csv', 'r').read
  content.each do |item|
    old_id = item[0]
    id = item[1]
    Claim.where(:user_id => old_id).update_all(:user_id => id)
    Comment.where(:user_id => old_id).update_all(:user_id => id)
    Permission.where(:user_id => old_id).update_all(:user_id => id)
    Rate.where(:user_id => old_id).update_all(:user_id => id)
  end
end
