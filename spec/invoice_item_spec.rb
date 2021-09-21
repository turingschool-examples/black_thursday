# frozen_string_literal: true

require 'SimpleCov'
SimpleCov.start

require 'BigDecimal'
require 'rspec'
require './lib/invoice_item'

describe InvoiceItem do
  before(:each) do
    @ii_hash = {
      id:         6,
      item_id:    7,
      invoice_id: 8,
      quantity:   1,
      unit_price: BigDecimal(10.99, 4),
      created_at: Time.now,
      updated_at: Time.now
    }
    @inv_item = InvoiceItem.new(@ii_hash)
  end

  it 'exists' do
    expect(@inv_item).to be_a InvoiceItem
  end

  describe '#id' do
    it 'returns an invoice item id' do
      expect(@inv_item.id).to eq(6)
    end
  end

  describe '#item_id' do
    it 'returns the item id' do
      expect(@inv_item.item_id).to eq(7)
    end
  end

  describe '#invoice_id' do
    it 'returns the invoice id' do
      expect(@inv_item.invoice_id).to eq(8)
    end
  end

  describe '#quantity' do
    it 'returns the quantity' do
      expect(@inv_item.quantity).to eq(1)
    end
  end

  describe '#unit_price' do
    it 'returns unit price' do
      expect(@inv_item.unit_price).to eq(BigDecimal(10.99, 4))
    end
  end

  describe '#created_at' do
    it 'returns created at time' do
      expect(@inv_item.created_at).to eq(@ii_hash[:created_at])
    end
  end

  describe '#updated_at' do
    it 'returns updated at time' do
      expect(@inv_item.updated_at).to eq(@ii_hash[:updated_at])
    end
  end

  describe '#unit_price_to_dollars' do
    it 'returns the price of the item in a float' do
      expect(@inv_item.unit_price_to_dollars).to eq(10.99)
    end
  end
end
