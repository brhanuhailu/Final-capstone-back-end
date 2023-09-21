class CreateHouse < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :area
      t.integer :number_of_rooms
      t.text :description
      t.string :location

      t.timestamps
    end
  end
end
