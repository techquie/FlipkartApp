class SessionsController < ApplicationController
  #skip_before_action :authorized, only: [:new, :create, :welcome]
  protect_from_forgery except: [:create]

  def add_product    
    @product = Product.new(product_params)

    if @product.save
      redirect_to "/sessions/addproduct", notice: "#{name} added to product list."
    else
      redirect_to "/sessions/addproduct", alert: "#{@product.errors.full_messages}" 
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
