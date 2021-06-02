require_relative './spec_helper'

RSpec.describe ItemRepository do
  context 'instantiation' do
    it 'exists' do
      ir = ItemRepository.new('./data/items.csv')
      expect(ir).to be_a(ItemRepository)
    end
  end

  context 'methods' do
    before :each do
      @ir = ItemRepository.new('./data/items.csv')
    end

    it 'generates Item instances' do
      expect(@ir.all).to be_a(Array)
    end
  end
end