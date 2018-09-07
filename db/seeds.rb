module Seeds
  def self.create_or_update(model, search_params, create_params)
    instance = model.find_or_initialize_by(search_params)
    instance.update!(create_params)
  end
end

require_relative '../apps/models/cat'
Seeds.create_or_update(CatsShop::Models::Cat, {name: 'Bengal Cats'}, {price: 300})
Seeds.create_or_update(CatsShop::Models::Cat, {name: 'Chinese Li Hua'}, {price: 250})
Seeds.create_or_update(CatsShop::Models::Cat, {name: 'Himalayan'}, {price: 150})
