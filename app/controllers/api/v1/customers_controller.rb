class Api::V1::CustomersController < ApplicationController

    respond_to :json
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    protect_from_forgery with: :null_session

    def not_found
        respond_with '{"error": "customer_not_found"}', status: :not_found
    end

    def index
      @customers = Customer.all
      render json: @customers, only: [:id, :name, :email, :password]
=begin      
      respond_to do |format|
        format.json { render :json => @customers.to_json, :status => :ok}
      end
=end
    end

    def destroy
        if Customer.find_by(id:params[:id]).nil?
            render json: {message:'no customer found'}
        else
            customer=Customer.find(params[:id])
            customer.destroy
            render json: { message: 'customer deleted successfully', :status => :ok }
        end
    end

    def show
        @customer = Customer.find(params[:id])
        render json: @customer.slice(:id, :name, :email, :password)
    end

    def create
        @customer = Customer.new(customer_params)

        if @customer.save
            render json: {message:'Customer added'}
        else
            render json: { errors: @customer.errors.full_messages }
        end

    end

    def update

        if Customer.find(params[:id]).nil?
            render json: {message:'Customer Not found'}
        else
            @customer=Customer.find(params[:id])
            if @customer.update(name: params[:name], password: params[:password])
                render json: { customer: @customer.slice(:id, :name, :email, :password), message: "customer updated successfully" }
            else
                render json: {errors: @customer.errors.full_messages}
            end
        end
    end

    private 
    def customer_params
        res = {}
        res[:name] = params[:name]
        res[:email] = params[:email]
        res[:password] = params[:password]
        return res
    end
    
end