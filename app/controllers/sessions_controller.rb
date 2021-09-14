class SessionsController < ApplicationController
  #skip_before_action :authorized, only: [:new, :create, :welcome]
  protect_from_forgery except: [:create]


  def myaccount
    if customer_signed_in?
      @wallet = Wallet.find_by customer_id: current_customer.id
      @orders = Order.where(customer_id: current_customer.id).order(order_date: :desc).all
      @addresses = Address.where(customer_id: current_customer.id).all
    end
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

  def add_product
    
    form_data = params[:product]
    name = form_data[:name]
    price = form_data[:price]
    description = form_data[:description]
    quantity= form_data[:quantity]
    category_id= form_data[:category_id]
    seller_id = current_seller.id
    
    @product = Product.new(name: name, price: price, description: description, 
      quantity: quantity, category_id: category_id, seller_id: seller_id)

    if @product.save
      redirect_to "/sessions/addproduct", notice: "#{name} added to product list."
    else
      redirect_to "/sessions/addproduct", alert: "#{@product.errors.full_messages}" 
    end
  end

  def sellersaccount
  end

  def viewproduct
    if seller_signed_in?
      @products = Product.where(seller_id: current_seller.id)
      @categories = Category.all
    end
  end

  def addproduct
    @product = Product.new
  end

  
=begin

  def new
  end

  def create

    @customer = Customer.find_by email: params[:username]
  
    if @customer && @customer.password.eql?(params[:password]) #@customer.authenticate(params[:password])      
      session[:user_id] = @customer.id     
      cart = Cart.find_by customer_id: @customer.id
      cart_products = CartProduct.where(cart_id: cart.id).all
      session[:cart_count] = cart_products.size
      session[:cart_id] = cart.id
      redirect_to '/flipkart'  
    else      
      redirect_to '/sessions/login'   
    end
  end

  def logout
    session[:user_id] = nil
    reset_session
    redirect_to root_url, notice: "Logged out"
  end
  def login
  end

  def welcome
  end
=end
end
