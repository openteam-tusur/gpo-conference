class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :year
      t.date :starts_on
      t.date :ends_on

      t.timestamps
    end
  end
end
