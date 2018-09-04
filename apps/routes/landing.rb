module CatsShop
  module Routes
    class Landing < Sinatra::Application
      get '/' do
        'Welcome! This is the best Cats shop in the world!'
      end
    end
  end
end
