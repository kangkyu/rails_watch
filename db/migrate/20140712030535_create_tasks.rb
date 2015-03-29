class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :episode
      t.datetime :date
      t.string :title
      
      t.timestamps
    end
  end
end
