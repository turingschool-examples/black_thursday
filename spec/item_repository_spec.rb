require_relative './spec_helper'
require './fixtures/items.csv'

RSpec.describe ItemRepository do
  context 'instantiation' do
    it 'exists' do
      ir = ItemRepository.new('./fixtures/items.csv')
      expect(ir).to be_a(ItemRepository)
    end
  end

  context 'methods' do
    before :each do
      @ir = ItemRepository.new('./fixtures/items.csv')
    end

    it 'generates Item instances' do
      item1 = @ir.all[1]
      item2 = @ir.all[-1]
      expect(item1.id).to eq(263395295)
      expect(item1.name).to eq('pencils')
      expect(item2.id).to eq(268716492)
      expect(item2.name).to eq('mattress')
      # expect(@ir.all).to be_a(Array)
    end
  end
end