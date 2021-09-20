ActiveAdmin.register Wallet do


index do
  selectable_column
  column :id
  column :customer
  column :amount
  column :pin
  column :created_at
  actions
end

show do |customer|
  attributes_table do
    row :customer
    row :amount
    row :pin
    row :created_at
    
  end
  #active_admin_comments
end

form do |f|
  f.inputs do
    f.input :customer
    f.input :amount
    #f.input :pin
  end
  f.actions
end

permit_params :amount, :pin, :customer_id
end
