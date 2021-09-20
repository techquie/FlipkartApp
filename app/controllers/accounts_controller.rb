class AccountsController < InheritedResources::Base

  def viewproduct
    if seller_signed_in?
      @products = Product.where(seller_id: current_seller.id)
      @categories = Category.all

      respond_to do |format|
        format.html
        format.csv { send_data @products.to_csv(['id', 'name', 'description', 'quantity', 'price', 'category_id', 'seller_id'])}
      end
      
    end
  end

  def import
    result = Product.import(params[:file])
    redirect_to viewproduct_accounts_path, notice: result[:message]
  end
  
  private

  def account_params
    params.require(:account).permit()
  end

end
