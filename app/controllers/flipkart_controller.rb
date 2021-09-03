class FlipkartController < ApplicationController
  
  def index
    if seller_signed_in?
      redirect_to '/sessions/sellersaccount', notice: "Welcome seller"
    else
      @products = Product.all
      @cart_product = current_order.cart_product.new
    end
  end

  def show
    @product = Product.find(params[:id])
    @cart_product = current_order.cart_product.new
  end

  def edit

  end

  def new

  end

end
