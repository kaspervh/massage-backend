class Product < ApplicationRecord

  def self.index_product_to_first(product_id)

    products = Product.all
    product_no = 2

    products.each do |product|
      if product.id.to_i == product_id.to_i
        product.update(index: 1)
      else
        product.update(index: product_no)
        product_no = product_no +1
      end
    end
  end

end
