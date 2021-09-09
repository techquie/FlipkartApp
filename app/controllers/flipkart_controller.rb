class FlipkartController < ApplicationController
  before_action :set_cart_count

  def set_cart_count
    def set_cart_count
      if customer_signed_in?
        customer_id = current_customer.present? ? current_customer.id : 0
        @cart = Cart.find_by customer_id: customer_id
        @cart_products = CartProduct.where(cart_id: @cart.id).all 
        session[:cart_count] = @cart_products.size
      end
    end
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
