FactoryBot.define do
  factory :cat, class: CatsShop::Models::Cat do
    name { FFaker::Animal.name }
    price { 100 + rand(500) }
  end
end