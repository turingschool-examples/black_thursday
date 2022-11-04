# frozen_string_literal: true

require 'rspec'
require './lib/merchant'

describe Merchant do
  #let(:m_repo) { MerchantRepo.new(data) }
  let(:merchant) { Merchant.new({ id: 5, name: 'Turing School' }, 'm_repo') }
  describe '#initialize' do
    it 'is an instance of Merchant' do
      expect(merchant).to be_a Merchant
    end

    it 'stores the merchants name' do
      expect(merchant.name).to eq('Turing School')
    end

    it 'stores the merchants id' do
      expect(merchant.id).to eq(5)
    end

    it 'stores a different name and id' do
      merchant = Merchant.new({ id: 10, name: 'Frankenstein and Sons' }, 'mr')

      expect(merchant.name).to eq('Frankenstein and Sons')
      expect(merchant.id).to eq(10)
    end
  end

  describe '#update' do
    it 'changes the @name of the Merchant' do
      # m = Merchant.new({ id: 5, name: 'Turing School' }, 'mr')
      merchant.update({ name: 'Test' })

      expect(merchant.name).to eq('Test')
    end
  end

  describe '#_items' do
    it 'fetches items owned by merchant' do
      engine = double('engine')
      item_repo = double('ItemRepo')
      allow(engine).to receive(:items).and_return(item_repo)
      allow(item_repo).to receive(:find_all_by_merchant_id).and_return(['item1', 'item2'])
      expect(merchant._items).to eq ['item1', 'item2']
    end
  end

  describe '#item_count' do
    it 'returns the number of items a merchant owns' do
      allow(merchant).to receive(:_items).and_return(['item1', 'item2'])
      expect(merchant.item_count).to eq(2)
    end
  end

  describe '#item_count' do
    it 'returns the number of items a merchant owns' do
      allow(merchant).to receive(:_items).and_return([1, 2])
      expect(merchant.item_prices).to eq(2)
    end
  end
end
