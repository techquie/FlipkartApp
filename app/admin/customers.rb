ActiveAdmin.register Customer do

form do |f|
  f.inputs do
    f.input :name
    f.input :email
    f.input :password
    f.input :password_confirmation
    f.input :active
  end
  f.actions
end

show do |customer|
  attributes_table do
    row :name
    row :email
    row :active
    row :created_at
    row :updated_at
    attributes_table_for customer.wallet do
      row :amount
      row :pin
    end

  end
  active_admin_comments
end

index do
  selectable_column
  column :id
  column :name
  column :email
  column :active
  #column "Wallets" do |a|
  #  link_to 'Add Amount', edit_admin_wallet_path(a)
  #end 
  actions
end

filter :name
filter :email
filter :id

permit_params :name, :password, :email, :password_confirmation, :active  

action_item :wallet_update, only: :show do
  link_to 'Update Wallet', wallet_update_admin_customer_path(customer), method: :get
end
member_action :wallet_update, method: :get do
  puts "********************************* hello #{params[:id]}"
  @wallet = Wallet.where(customer_id: params["id"])
end

action_item :showimport, only: :show do
  link_to 'Show Import', showimport_admin_customer_path(customer), method: :get
end

member_action :showimport, :method=>:get do
  puts "*******************************"
  @wallet = Wallet.where(customer_id: params["id"])
  puts "******************************* #{@wallet.inspect}"
end


controller do

  def showimport
    @product = Product.find(params[:id])
    
  end

  def import
    # renders view 'app/views/admin/products/showimport.html.haml'
  end
  

end


#action_item only: :show do 
#  link_to 'Add Amount', '/admin/wallets/1/edit'
#end

end
