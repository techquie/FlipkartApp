class FlipkartController < ApplicationController
  def index
    @products = Product.all
    @cart_product = current_order.cart_product.new
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
