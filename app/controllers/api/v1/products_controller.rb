class Api::V1::ProductsController < ApplicationController
    respond_to :json

    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    protect_from_forgery with: :null_session

    before_action :doorkeeper_authorize! unless Rails.env.test?

    def not_found
        respond_with '{"error": "product_not_found"}'
    end

    def index
        @products = Product.all
        render json: @products, only: [:id, :name, :description, :price, :quantity]
    end

    def show
        @product = Product.find(params[:id])
        render json: @product
    end

    def destroy
        if Product.find_by(id:params[:id]).nil?
            render json: {message:'no product found'}
        else
            product=Product.find(params[:id])
            product.destroy
            render json: { message: 'product deleted successfully', :status => :ok }
        end
    end

    def create
        @product = Product.new(product_params)
        if @product.save
            render json: {message:'Product added'}
        else
            render json: { errors: @product.errors.full_messages }
        end
    end

    def update
        if Product.find(params[:id]).nil?
            render json: {message:'Product Not found'}
        else
            @product = Product.find(params[:id])
            if @product.update(name: params[:price], password: params[:quantity])
                render json: { product: @product.slice(:id, :name, :description, :price, :quantity), message: "customer updated successfully" }
            else
                render json: {errors: @product.errors.full_messages}
            end
        end
    end

    private 
    def product_params
        res = {}
        res[:name] = params[:name]
        res[:price] = params[:price]
        res[:quantity] = params[:quantity]
        res[:description] = params[:description]
        res[:category_id] = params[:category_id]
        res[:seller_id] = params[:seller_id]
        return res
    end
    
    def current_customer
        @current_customer = Customer.find_by(id: doorkeeper_token[:resource_owner_id])
    end

end

