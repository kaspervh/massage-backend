class AddServiceToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :service, :string
  end
end
