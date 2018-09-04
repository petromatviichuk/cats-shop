module CatsShop
  module Models
    class Cat < ActiveRecord::Base
      validates :name, presence: true
      validates :price, presence: true
    end
  end
end