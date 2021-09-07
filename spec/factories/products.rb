FactoryBot.define do
  factory :product do
    name { 'Mi Note 9 Pro'}
    price { 1200 }
    quantity { 12 }
    description { "Brand : Mi Handset, Launched in 2019, 4/8GB RAM, 64/128GB ROM"}
    association :category
    association :seller
  end
end
