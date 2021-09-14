ActiveAdmin.register Customer do

form do |f|
  f.inputs do
    f.input :name
    f.input :email
    f.input :password
    f.input :password_confirmation
  end
  f.actions
end
index do
  selectable_column
  column :id
  column :name
  column :email
  actions
end

filter :name
filter :email
filter :id
=begin
  permit_params do
     permitted = [:name, :password, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
     permitted << :other if params[:action] == 'create' && current_user.admin?
     permitted
  end
=end
  permit_params :name, :password, :email, :password_confirmation  
end
