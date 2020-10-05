class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :duration
      t.text :description
      t.text :promo_image

      t.timestamps
    end
  end
end
