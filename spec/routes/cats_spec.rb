require 'spec_helper'
require_relative '../../apps/routes/cats'

RSpec.describe CatsShop::Routes::Cats do
  def app
    described_class
  end

  describe '/cats/info' do
    def app_response
      get '/cats/info'
      last_response.body
    end

    context 'no cats' do
      it 'shows correct count' do
        expect(app_response).to include('0 cats')
      end
    end

    context 'with cats' do
      before { create_list(:cat, 5) }

      it 'shows correct count' do
        expect(app_response).to include('5 cats')
      end
    end
  end
end