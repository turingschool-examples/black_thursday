require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/item_repository'

RSpec.describe ItemRepository do
  before do
    @ir = ItemRepository.new
  end
  describe '#initialize' do
    it 'exists' do
      expect(@ir).to be_instance_of(ItemRepository)
    end
  end
end
