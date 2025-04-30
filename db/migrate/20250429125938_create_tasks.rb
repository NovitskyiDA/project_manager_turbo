class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.references :project, null: false, foreign_key: true
      t.references :parent, null: true, foreign_key: { to_table: :tasks }
      t.datetime :expires_at

      t.timestamps
    end

    add_index :tasks, :expires_at
    add_index :tasks, [ :project_id, :expires_at ]
  end
end
