ActiveAdmin.register Customer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :password, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #

=begin
form do |f|
  f.inputs do
    f.input :name
    f.input :email
    f.input :password
    f.input :password_confirmation
  end
  f.actions
end
=end
=begin
  permit_params do
     permitted = [:name, :password, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
     permitted << :other if params[:action] == 'create' && current_user.admin?
     permitted
  end
=end
  permit_params :name, :password, :email  
end
