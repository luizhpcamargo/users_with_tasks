class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
