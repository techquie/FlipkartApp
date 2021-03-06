class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  def edit_by_seller
  end

  def view_orders
    order_id = params[:id]
    @order = Order.find(order_id)
    @address =  @order.address
    @order_products = OrderProduct.where(order_id: @order.id).all
    
    @products = Product.all
    @totalAmount = 0
    @order_products.each do |order_product| 
      product = @products.find { |obj| obj.id == order_product.product_id}
      @totalAmount = @totalAmount + order_product.quantity * product.price
    end
    #redirect_to "/sessions/view_orders"
  end
  

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.seller_id = current_seller.id
    respond_to do |format|
      if @product.save
        format.html { redirect_to '/sessions/sellersaccount', notice: "#{@product.name} was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to '/sessions/sellersaccount', notice: "#{@product.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :price, :description, :quantity, :category_id, :seller_id, images: [])
    end
end
