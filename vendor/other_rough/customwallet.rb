ActiveAdmin.register Wallet do
    form do |f|
        f.inputs do
        f.input :customer
        f.input :amount
        f.semantic_errors *f.object.errors.keys
        end
        f.actions
    end
    f.actions do
      f.submit 'Update' as: :button
    end

    controller do
        amount = params[:amount]
            
        customer_id = attrs[:customer_id]
        
        @wallet = Wallet.where(customer_id: customer_id).update(amount: amount)
      
        if @wallet.save
          redirect_to '/admin/customers/'+customer_id
        else
          render :new
        end                 
      end

end
