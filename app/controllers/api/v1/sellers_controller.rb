class Api::V1::SellersController < ApplicationController

    respond_to :json
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    protect_from_forgery with: :null_session

    def not_found
        respond_with '{"error": "seller_not_found"}', status: :not_found
    end

    def index
      @sellers = Seller.all
      render json: @sellers, only: [:id, :name, :email]
    end

    def destroy
        if Seller.find_by(id:params[:id]).nil?
            render json: {message:'no seller found'}
        else
            @seller=Seller.find(params[:id])
            @seller.destroy
            render json: { message: 'Seller deleted successfully', :status => :ok }
        end
    end

    def show
        @seller = Seller.find(params[:id])
        render json: @seller.slice(:id, :name, :email)
    end

    def create
        @seller = Seller.new(seller_params)

        if @seller.save
            render json: {message:'Seller added'}
        else
            render json: { errors: @seller.errors.full_messages }
        end

    end

    def update
        if Seller.find_by(id:params[:id]).nil?
            render json: {message:'no seller found'}
        else
            @seller=Seller.find(params[:id])
            if @seller.update(name: params[:name], password: params[:password])
                render json: { seller: @seller.slice(:id, :name, :email), message: "seller updated successfully" }
            else
                render json: {errors: @seller.errors.full_messages}
            end
        end
    end

    private 
    def seller_params
        res = {}
        res[:name] = params[:name]
        res[:email] = params[:email]
        res[:password] = params[:password]
        return res
    end
    
end