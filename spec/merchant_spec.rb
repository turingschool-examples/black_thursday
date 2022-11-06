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
      merch_repo = double('merch_repo')
      engine = double('engine')
      item_repo = double('ItemRepo')
      merchant = Merchant.new({ id: 5, name: 'Turing School' }, merch_repo)
      allow(merch_repo).to receive(:engine).and_return(engine)
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

  describe '#item_prices' do
    it 'returns the number of items a merchant owns' do
      item1 = double('item1')
      item2 = double('item2')
      allow(item1).to receive(:unit_price).and_return(1)
      allow(item2).to receive(:unit_price).and_return(3)
      allow(merchant).to receive(:_items).and_return([item1, item2])
      expect(merchant.item_prices).to eq([1, 3])
    end
  end

  describe '#avg_item_price' do
    it 'returns the average price of the merchants items' do
      item1 = double('item1')
      item2 = double('item2')
      allow(item1).to receive(:unit_price).and_return(1)
      allow(item2).to receive(:unit_price).and_return(3)
      allow(merchant).to receive(:_items).and_return([item1, item2])
      expect(merchant.item_prices).to eq([1, 3])
      expect(merchant.avg_item_price).to eq 2.0
    end
  end

  describe '#_invoices' do
    it 'fetches invoices created by merchant' do
      merch_repo = double('merch_repo')
      engine = double('engine')
      invoice_repo = double('InvoiceRepo')
      merchant = Merchant.new({ id: 5, name: 'Turing School' }, merch_repo)
      allow(merch_repo).to receive(:engine).and_return(engine)
      allow(engine).to receive(:invoices).and_return(invoice_repo)
      allow(invoice_repo).to receive(:find_all_by_merchant_id).and_return(['invoice1', 'invoice2'])
      expect(merchant._invoices).to eq ['invoice1', 'invoice2']
    end
  end

  describe '#invoice_count' do
    it 'returns the number of invoices a merchant keeps' do
      allow(merchant).to receive(:_invoices).and_return(['invoice1', 'invoice2'])
      expect(merchant.invoice_count).to eq(2)
    end
  end

  describe '#has_pending?' do
    it 'returns whether or not the merchant has a pending invoice' do
      item1 = double('invoice1')
      item2 = double('invoice2')
      allow(merchant).to receive(:_invoices).and_return([invoice1, invoice2])
    end
  end
end
