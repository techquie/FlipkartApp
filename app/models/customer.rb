class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_one :wallet, dependent: :destroy
    has_many :address, dependent: :destroy
    has_many :payments

    validates :name, presence: true, length: {minimum: 5, maximum: 20}
    validates :password, presence: true, length: {minimum: 5, maximum: 10}
    validates :email, uniqueness: true, presence: true 

    after_save :create_cart
    after_save :create_wallet
    
    def create_cart
        @cart = Cart.new(:customer_id => self.id)
        if @cart.save
            puts "cart created for customer id = #{self.id}"
        else
            puts "cart could not be created for customer id = #{self.id}"
        end
    end

    def create_wallet
        @wallet = Wallet.new(:customer_id => self.id, :amount => 1000, :pin => 1234)
        if @wallet.save
            puts "wallet created for customer id = #{self.id} with default amount = 1000 and pin = 1234"
        else
            puts "wallet could not be created for customer id = #{self.id}"
        end
    end
end
