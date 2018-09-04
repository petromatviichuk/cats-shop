require_relative 'routes/landing'
require_relative 'routes/cats'

module CatsShop
  class App < Sinatra::Application
    register Sinatra::ActiveRecordExtension

    configure do
      disable :method_override
      disable :static
    end

    use CatsShop::Routes::Landing
    use CatsShop::Routes::Cats
  end
end