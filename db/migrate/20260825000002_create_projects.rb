class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :short_description
      t.text :description
      t.text :technologies
      t.string :github_url
      t.string :live_url
      t.boolean :featured, default: false, null: false
      t.integer :position, default: 0, null: false
      t.timestamps
    end
  end
end
