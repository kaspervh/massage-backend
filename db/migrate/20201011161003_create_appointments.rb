class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.integer :work_day_id
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
