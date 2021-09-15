class CartProductsController < ApplicationController
  before_action :set_cart_product, only: %i[ show edit update destroy ]
  before_action :set_cart_count

  # GET /cart_products or /cart_products.json
  def index
    if customer_signed_in?
      #customer_id = current_customer.present? ? current_customer.id : 0
      @products = Product.all
      
      @cart = current_customer.cart #Cart.find_by customer_id: customer_id
      @wallet = current_customer.wallet

      @cart_products = CartProduct.where(cart_id: @cart.id).all
      @addresses = Address.where(customer_id: current_customer.id).all

      @totalAmount = 0
      @cart_products.each do |cart_product| 
        product = @products.find { |obj| obj.id == cart_product.product_id}
        @totalAmount = @totalAmount + cart_product.quantity * product.price
      end
    else
      redirect_to root_url, notice: "Please login to view cart"
    end
  end

  # GET /cart_products/1 or /cart_products/1.json
  def show
  end

  # GET /cart_products/new
  def new
    @cart_product = CartProduct.new
  end

  # GET /cart_products/1/edit
  def edit
  end

  # POST /cart_products or /cart_products.json
  def create

    #if customer is logged in 
    if customer_signed_in?

      @cart_product = CartProduct.new(cart_product_params)
      customer_id = current_customer.id
      @cart = current_customer.cart 
      @cart_product.cart_id = @cart.id
      @product = @cart_product.product 
      
      flag = CartProduct.exists?(:product_id => @cart_product.product_id, :cart_id =>@cart_product.cart_id)
      
      if flag
        localCartProduct = CartProduct.find_by product_id: @cart_product.product_id, cart_id: @cart_product.cart_id
          @cart_product.quantity = @cart_product.quantity + localCartProduct.quantity.to_i
      end

      if(@cart_product.quantity <= @product.quantity)
       
        if flag
          if CartProduct.where(product_id: @cart_product.product_id).where(cart_id: @cart_product.cart_id).update_all(quantity: @cart_product.quantity)
            puts "updated successfully"
            redirect_to root_url, notice: "#{@product.name} added to cart"
          else
            redirect_to root_url, notice: "#{@product.name} can't be added to cart"
          end
        else
          #respond_to do |format|
            if @cart_product.save
              session[:cart_id] = @cart.id
              cart_products = CartProduct.where(cart_id: @cart.id).all
              session[:cart_count] = cart_products.size

              title = Product.find(@cart_product.product_id).name
              redirect_to root_url, notice: "#{title} added to cart"
            else
              redirect_to root_url, notice: "#{title} couldn't added to cart"
            end
        end
      else
        redirect_to root_url, notice: "Available product is less than enterted quantity"
      end
    else
      redirect_to root_url, notice: "Please login to ADD into cart"
    end
  end

  # PATCH/PUT /cart_products/1 or /cart_products/1.json
  def update
    respond_to do |format|
      if @cart_product.update(cart_product_params)
        format.html { redirect_to @cart_product, notice: "Cart product was successfully updated." }
        format.json { render :show, status: :ok, location: @cart_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_products/1 or /cart_products/1.json
  def destroy
    cart_id = @cart_product.cart_id
    @cart_product.destroy

    cart_products = CartProduct.where(cart_id: cart_id).all
    session[:cart_count] = cart_products.size

    respond_to do |format|
      title = Product.find(@cart_product.product_id).name
      format.html { redirect_to cart_products_url, notice: "#{title} removed successfully." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_product
      @cart_product = CartProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_product_params
      params.require(:cart_product).permit(:quantity, :product_id, :cart_id)
    end

    def set_cart_count
      if customer_signed_in?
        customer_id = current_customer.present? ? current_customer.id : 0
        @cart = Cart.find_by customer_id: customer_id
        @cart_products = CartProduct.where(cart_id: @cart.id).all 
        session[:cart_count] = @cart_products.size
      end
    end
end
