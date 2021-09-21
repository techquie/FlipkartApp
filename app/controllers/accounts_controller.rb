class AccountsController < InheritedResources::Base

  def viewproduct
    if seller_signed_in?
      @products = Product.where(seller_id: current_seller.id)
      respond_to do |format|
        format.html
        format.csv { send_data @products.to_csv(['id', 'name', 'description', 'quantity', 'price', 'category_id', 'seller_id'])}
      end
    else
      redirect_to '/sellers/sign_in', notice: 'please login'
    end
  end

  def sellersaccount
  end

  def myaccount
    if customer_signed_in?
      @wallet = current_customer.wallet
      @orders = Order.where(customer_id: current_customer.id).order(order_date: :desc).all
      @addresses = current_customer.address
    else
      redirect_to '/customers/sign_in', notice: 'please login'
    end
  end

  
  def import
    result = Product.import(params[:file])
    redirect_to viewproduct_accounts_path, notice: result[:message]
  end
  
  def productorderhistory
    if seller_signed_in?
      #make use of currnt_seller /associatons 
      #ids = Product.where(seller_id: current_seller).all.ids
      ids = current_seller.product.all.ids
      @order_products = OrderProduct.where(:product_id => ids).order(id: :desc)
    else
      redirect_to '/sellers/sign_in', notice: 'please login'
    end
  end

  private

  def account_params
    params.require(:account).permit()
  end

end
