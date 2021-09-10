class Api::V1::CustomController < ApplicationController

    respond_to :json
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    protect_from_forgery with: :null_session

    def not_found
        respond_with '{"error": "order_product_not_found"}', status: :not_found
    end

    def add_to_cart
        
        #required params: customer_id, product_id, quantity
        #get cart_id from customer obj
        #update- also get customer_id from current_signed in customer

        customer_id = params[:customer_id]
        product_id = params[:product_id]
        quantity = params[:quantity].to_i
        cart_id = Cart.find_by(customer_id: customer_id).id

        @cart_product = CartProduct.new(cart_id: cart_id, product_id: product_id, quantity: quantity)
        @product = @cart_product.product

        flag = CartProduct.exists?(:product_id => product_id, :cart_id => cart_id)
        if flag
            localCartProduct = CartProduct.find_by product_id: product_id, cart_id: cart_id
            quantity = quantity + localCartProduct.quantity.to_i
        end

        if(@product.quantity >= quantity)
            if flag
                if CartProduct.where(product_id: product_id).where(cart_id: cart_id).update_all(quantity: quantity.to_i)
                    title = @cart_product.product.name
                    render json: {message: "#{title} added to cart"}
                else
                    render json: {error: "can't be added(update) to cart" }
                end
            else
                if @cart_product.save
                    title = @cart_product.product.name
                    render json: {message: "#{title} added to cart"}
                else
                    render json: {errors: @cart_product.errors.full_messages}
                end
            end
        else
            render json: {message: "Product: Available quantity = #{@product.quantity} || Requested Quantity = #{quantity}" }
        end
    end

    def place_order
        #params-cart_id,customer_id
        cart_id = params[:cart_id]
        customer_id = params[:customer_id]

        @cart_products = CartProduct.where(cart_id: cart_id).all
        @order = Order.new(:customer_id => customer_id, :address_id => 1, order_date: Time.now)

        if @cart_products
            if @order.save
              order_id = @order.id
              @cart_products.each do |product|
                order_product = OrderProduct.new(order_id: order_id, product_id: product.product_id, quantity: product.quantity)
        
                if order_product.save
                    p = order_product.product #Product.find(order_product.product_id)
                    p.update(quantity: p.quantity - order_product.quantity)
                    product.destroy
                else
                    puts @order_product.errors.full_messages
                end
              end
              render json: { message: "Thank You ! Order placed successfully order id [#{order_id}]"}
            else
              render json: { errors: @order.errors.full_messages }
            end
          else
            render json: {errors: "cart is empty, couldn't be initiated"}
        end
    end

    def view_orders
        customer_id = params[:customer_id]
        @orders = Order.where(customer_id: customer_id).order(order_date: :desc).all
        #@order_products = OrderProduct.find_by(customer_id: customer_id)
        render json: @orders #, only: [:id, :name, :email, :password]
    end
end
