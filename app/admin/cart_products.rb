ActiveAdmin.register CartProduct do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :quantity, :product_id, :cart_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:quantity, :product_id, :cart_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :quantity, :product_id, :cart_id
end
