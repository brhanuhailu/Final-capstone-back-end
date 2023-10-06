class CreateReservation < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :user , null: false, foreign_key: true
      t.references :house ,null: false, foreign_key: true
      t.date :booking_date
      t.date :checkout_date
      t.decimal :total_charge

      t.timestamps
    end
  end
end
