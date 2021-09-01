class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.decimal :amount
      t.integer :pin
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
