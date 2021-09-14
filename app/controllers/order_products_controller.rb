class OrderProductsController < ApplicationController
  before_action :set_order_product, only: %i[ show edit update destroy ]
  
  def place_order
    puts "-: order place initiated :-"

    @form_data = params[:product_list]
    customer_id =  @form_data[:customer_id]
    cart_id = @form_data[:cart_id]

    @cart_products = CartProduct.where(cart_id: cart_id).all
    @order = Order.new(:customer_id => customer_id, :address_id => 1, order_date: Time.now)

    if @cart_products
      if @order.save
        @cart_products.each do |product|
          order_product = OrderProduct.new(order_id: @order.id, product_id: product.product_id, quantity: product.quantity)

          if order_product.save
            #change this logic with association
            #p = order_product.product #Product.find(order_product.product_id)
            #p.update(quantity: p.quantity - order_product.quantity)
            product.destroy
            puts "order placed for #{product.id} in order_id #{@order.id}"
          else
            puts "order can't be placed for #{product.id} in order_id #{@order.id}"
          end
        end
        session[:cart_count] = 0
        redirect_to '/cart_products', notice: "Thank You ! Order placed successfully order id [#{@order.id}]"
      else
        puts @order.errors.full_messages
        redirect_to cart_product_path, notice: "order couldn't be initiated"
      end
    else
      redirect_to cart_product_path, notice: "cart is empty, couldn't be initiated"
    end
  end


  # GET /order_products or /order_products.json
  def index
    @order_products = OrderProduct.all    
    @products = Product.all
  end

  # GET /order_products/1 or /order_products/1.json
  def show
  end

  # GET /order_products/new
  def new
    @order_product = OrderProduct.new
  end

  # GET /order_products/1/edit
  def edit
  end

  # POST /order_products or /order_products.json
  def create
    @order = current_order
    @order_product = @order.order_product.new(order_params)
    puts @order_product

    @order_product = OrderProduct.new(order_product_params)

    respond_to do |format|
      if @order_product.save
        format.html { redirect_to @order_product, notice: "Order product was successfully created." }
        format.json { render :show, status: :created, location: @order_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_products/1 or /order_products/1.json
  def update
    respond_to do |format|
      if @order_product.update(order_product_params)
        format.html { redirect_to @order_product, notice: "Order product was successfully updated." }
        format.json { render :show, status: :ok, location: @order_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_products/1 or /order_products/1.json
  def destroy
    @order_product.destroy
    respond_to do |format|
      format.html { redirect_to order_products_url, notice: "Order product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_product
      @order_product = OrderProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_product_params
      params.require(:order_product).permit(:quantity, :order_id, :product_id)
    end
end
