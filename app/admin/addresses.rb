ActiveAdmin.register Address do
  permit_params :city, :pincode, :contact, :customer_id, :default
end
