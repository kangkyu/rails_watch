class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :user_id
      t.integer :task_id
      t.boolean :completed
      t.datetime :completed_at
      
      t.timestamps
    end
  end
end
