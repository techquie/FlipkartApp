namespace :credit do
    desc "Credit amount to customer wallet"
    task :wallet_amount =>:environment do
        query = "select ord.customer_id, sum(op.quantity * (select p.price from products p where id = product_id )) from order_products op
        join orders ord on ord.id = op.order_id where ord.order_date > now() - interval '2 day' group by ord.customer_id;"
        
        @record = ActiveRecord::Base.connection.execute(query)
        @record.each do |t|
            q1 = Wallet.find_by(:customer_id => t.values_at("customer_id"))
            amount = (t.values_at("sum")).first
            puts "previous balance #{q1.amount}"
            puts "amount to be credit = #{amount * 0.25}"
            wallet = Wallet.find(q1.id).update(amount: q1.amount + amount * 0.25)

            if wallet
                puts "Amount credited successfully for #{q1.id} || new balance = #{Wallet.find(q1.id).amount}"
            else
                puts "Failed to credit balance for #{q1.id}"
            end
    
        end
    end
end