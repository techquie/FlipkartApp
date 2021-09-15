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

  def productorderhistory
    if seller_signed_in?
      ids = Product.where(seller_id: current_seller).all.ids
      @order_products = OrderProduct.where(:product_id => ids).order(id: :desc)
      @products = Product.all
      #total order, total count of product, 
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
    @product = Product.new(product_params)

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

  private 

  def product_params
    res = {}
    form_data = params[:product]
    res[:name] = form_data[:name]
    res[:price] = form_data[:price]
    res[:description] = form_data[:description]
    res[:quantity] = form_data[:quantity]
    res[:category_id] = form_data[:category_id]
    res[:seller_id] = current_seller.id
    return res
  end

end
