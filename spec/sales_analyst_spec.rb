# frozen_string_literal: true

require './lib/sales_analyst'
require './lib/merchant_repository'
require './lib/item_repository'
require 'bigdecimal'

RSpec.describe SalesAnalyst do
  let(:sa) { SalesAnalyst.new }

  describe '#initialize' do
    it 'exists' do
      expect(sa).to be_a SalesAnalyst
    end
  end

  describe '#average_items_per_merchant' do
    it 'returns a float for average # of items per merchant' do
      mr = MerchantRepository.new
      ir = ItemRepository.new
      allow(mr).to receive(:all).and_return(['merchant1', 'merchant2',])
      allow(ir).to receive(:all).and_return(['item1', 'item2', 'item3', 'item4'])
      
      expect(sa.average_items_per_merchant(ir,mr)).to eq (2)
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'returns the strd dev for # of items per merchant' do
      mr = double('MerchantRepo')
      ir = double('ItemRepo')
      allow(mr).to receive(:all).and_return(['merchant1', 'merchant2',])
      allow(ir).to receive(:all).and_return(['item1', 'item2', 'item3', 'item4'])
      
      expect(sa.average_items_per_merchant_standard_deviation(ir, mr)).to eq(0)
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'returns a list of merchants whose standard deviation of # of items is 1 or greater' do
    
    end
  end

  describe '#average_item_price_for_merchant' do
    it "returns the average price of a merchant's items" do
      item_repo = double('ItemRepo')
      allow(item_repo).to receive(:find_all_by_merchant_id).and_return([BigDecimal("2"), BigDecimal("5"), BigDecimal("3"), BigDecimal("9")])
      
      expect(sa.average_item_price_for_merchant(item_repo, 1111111)).to eq 0.475e1
    end
  end

  # describe '#average_average_price_per_merchant' do
  #   it 'returns an average of all merchant average item price' do
  #     item_repo = double('ItemRepo')
  #     allow(item_repo).to receive(:find_all_by_merchant_id).and_return([2, 5, 3, 9])
  #     expect(sa.average_item_price_for_merchant(item_repo, 22222)).to eq 
  #   end
  # end

  describe '#golden_items' do
    it '' do

    end
  end
end
