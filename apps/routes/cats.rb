require_relative '../models/cat'

module CatsShop
  module Routes
    class Cats < Sinatra::Application
      get '/cats/info' do
        "We have #{CatsShop::Models::Cat.count} cats in the shop"
      end
    end
  end
end
