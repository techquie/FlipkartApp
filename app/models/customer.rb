class Customer < ApplicationRecord
    
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_one :wallet, dependent: :destroy
    has_many :address, dependent: :destroy
    has_one :cart, dependent: :destroy
    has_many :payments

    validates :name, presence: true, length: {minimum: 5, maximum: 20}
    validates :password, presence: true, length: {minimum: 5, maximum: 10}
    validates :email, uniqueness: true, presence: true 

    after_create :create_cart
    after_create :create_wallet
    
    def create_cart
        @cart = Cart.new(:customer_id => self.id)
        if @cart.save
            puts "cart created for customer id = #{self.id}"
        else
            puts "cart could not be created for customer id = #{self.id}"
        end
    end

    def create_wallet
        pin = rand.to_s[2..6]
        @wallet = Wallet.new(:customer_id => self.id, :amount => 100000, :pin => pin)
        if @wallet.save
            puts "wallet created for customer id = #{self.id} with default amount = 1000"
        else
            puts "wallet could not be created for customer id = #{self.id}"
        end
    end

    #configuration for doorkeeper

    has_many :access_tokens,
    class_name: 'Doorkeeper::AccessToken',
    foreign_key: :resource_owner_id,
    dependent: :delete_all
    
    class << self
        def authenticate(email, password)
          customer = Customer.find_for_authentication(email: email)
          customer.try(:valid_password?, password) ? customer : nil
        end
    end

end
