class CreateExperiences < ActiveRecord::Migration[8.0]
  def change
    create_table :experiences do |t|
      t.string :title, null: false
      t.string :company
      t.string :subtitle
      t.text :short_description
      t.text :description
      t.text :technologies
      t.date :start_date
      t.date :end_date
      t.boolean :current, default: false, null: false
      t.boolean :featured, default: false, null: false
      t.integer :position, default: 0, null: false
      t.timestamps
    end
  end
end
