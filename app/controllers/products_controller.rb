class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  #GET /move_to_top
  def move_to_top
    Product.index_product_to_first(params[:product_id])

    @products = Product.all.order("index")

    render json: @products

  end

  # GET /products
  def index
    @products = Product.all.order("index")

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      @product.update(index: Product.all.count + 1)
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:product_id, :user_id, :name, :duration, :description, :promo_image, :index)
    end
end
