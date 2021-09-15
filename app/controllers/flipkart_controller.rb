class FlipkartController < ApplicationController
  before_action :set_cart_count

  def set_cart_count
    if customer_signed_in?
      @cart = current_customer.cart
      @cart_products = CartProduct.where(cart_id: @cart.id).all 
      session[:cart_count] = @cart_products.size
    end
  end

  def search
    form = params[:searchform]
    query = form[:query]
    @products = Product.where('name LIKE ?', '%'+ query + '%')
    @cart_product = current_order.cart_product.new

    flash[:notice] = "Search result for #{query}"

  end
  
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
