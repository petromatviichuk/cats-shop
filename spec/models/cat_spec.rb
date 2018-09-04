require 'spec_helper'
require_relative '../../apps/models/cat'

RSpec.describe CatsShop::Models::Cat do
  let(:cat) { build(:cat) }

  describe 'validations' do
    it 'are valid for factory object' do
      expect(cat).to be_valid
    end

    it 'validates name' do
      cat.name = nil
      expect(cat).to_not be_valid
    end

    it 'validates price' do
      cat.price = nil
      expect(cat).to_not be_valid
    end
  end
end