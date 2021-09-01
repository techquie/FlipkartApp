class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :city
      t.integer :pincode
      t.string :contact
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
