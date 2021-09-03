class SessionsController < ApplicationController
  #skip_before_action :authorized, only: [:new, :create, :welcome]
  protect_from_forgery except: [:create]


  def myaccount
    if customer_signed_in?
      @wallet = Wallet.find_by customer_id: current_customer.id
      @orders = Order.where(customer_id: current_customer.id).all
      @addresses = Address.where(customer_id: current_customer.id).all
    end
  end

  def sellersaccount
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
