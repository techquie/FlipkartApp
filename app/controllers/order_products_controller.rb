class OrderProductsController < ApplicationController
  before_action :set_order_product, only: %i[ show edit update destroy ]
  before_action :customer_signed_in

  def order_payment
    puts "-: order place initiated :-"
    if customer_signed_in?
      @form_data = params[:formdata]
      customer_id =  @form_data[:customer_id]
      @wallet = current_customer.wallet
      
      if @wallet.pin.to_i == @form_data[:securitycode].to_i
        @cart_products = CartProduct.where(cart_id: current_customer.cart.id).all
        @order = Order.new(:customer_id => customer_id, :address_id => @form_data[:address_id], order_date: Time.now)
        if @cart_products
          if @order.save
            @cart_products.each do |product|
              order_product = OrderProduct.new(order_id: @order.id, product_id: product.product_id, quantity: product.quantity)

              if order_product.save
                product.destroy
              end
            end
            
            if @wallet.update(amount: (@wallet.amount - @form_data[:total_amount].to_i))
              puts "payable amount deducted successfully"
            end

            @payment = Payment.new(mode: @form_data[:paymentoption], order_id: @order.id)
            @payment.save
            session[:cart_count] = 0
            
            redirect_to controller: 'order_products', action: 'order_summary', order_id: @order.id
          else
            puts @order.errors.full_messages
            redirect_to cart_product_path, notice: "order couldn't be initiated"
          end
        else
          redirect_to cart_product_path, notice: "cart is empty, couldn't be initiated"
        end
      else
        redirect_to '/cart_products', alert: "Invalid Security code"
      end
    else
      redirect_to root_path, notice: "customer not logged in, couldn't be initiated"
    end
  end

  def order_summary
    order_id = params[:order_id]
    if Order.exists?(:id => order_id)
      @order = Order.find(order_id)
      @order_products = OrderProduct.where(order_id: order_id).all
      @total_amount = 0
      @order_products.each do |order_product| 
          @total_amount = @total_amount + order_product.quantity * order_product.product.price
      end
    else
      redirect_to root_url, notice: "Failed to retrieve order "
    end
    
  end

  def place_order
    if customer_signed_in?
      @form_data = params[:product_list]
      @wallet = current_customer.wallet
    else
      redirect_to '/customers/sign_in', notice: 'please login to continue'
    end
  end

  # GET /order_products or /order_products.json
  def index
    @order_products = OrderProduct.all    
    @products = Product.all
    order_id = params[:order_id]
    
    if !order_id.nil?
      @order = Order.find(order_id)
      @order_products = OrderProduct.where(order_id: order_id).all
      @total_amount = 0
      @order_products.each do |order_product| 
          @total_amount = @total_amount + order_product.quantity * order_product.product.price
      end
  
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "order summary",template: 'order_products/order_summary.html.erb'
        end
      end
    else
      flash[:notice] = "Restricted !"
    end


  end

  def show
  end

  def new
    @order_product = OrderProduct.new
  end

  def edit
    order_id = params[:order_id]
    @order = Order.find(order_id)
    @order_products = OrderProduct.where(order_id: order_id).all
    @total_amount = 0
    @order_products.each do |order_product| 
        @total_amount = @total_amount + order_product.quantity * order_product.product.price
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "payments",template: 'order_products/order_summary.html.erb'
      end
    end


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
