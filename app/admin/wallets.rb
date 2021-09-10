ActiveAdmin.register Wallet do

=begin  permit_params do
     permitted = [:amount, :pin, :customer_id]
     permitted << :other if params[:action] == 'create' && current_user.admin?
     permitted
  end
=end
permit_params :amount, :pin, :customer_id
end
