class AddIndexToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :index, :integer
  end
end
