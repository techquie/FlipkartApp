ActiveAdmin.register Seller do

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
  
  show do 
    attributes_table do
      row :name
      row :email
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
  
  filter :name
  filter :email
  filter :id
  # permit_params do
  #   permitted = [:name, :email, :password]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :name, :email, :password, :password_confirmation
end
