ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :price, :description, :quantity, :category_id, :seller_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price, :description, :quantity, :category_id, :seller_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :name, :price, :description, :quantity, :category_id, :seller_id
end
