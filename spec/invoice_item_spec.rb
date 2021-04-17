require './lib/invoice_item'
require 'bigdecimal'
require 'RSpec'

RSpec.describe InvoiceItem do
  describe '#initialize' do
    ii = InvoiceItem.new(
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :cent_price => 1099,
      :created_at => Time.now,
      :updated_at => Time.now
    )
    it 'exists' do
      expect(ii).to be_an_instance_of(InvoiceItem)
    end
  end
  describe 'instance variables' do
    ii = InvoiceItem.new(
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :cent_price => 1099,
      :created_at => Time.now,
      :updated_at => Time.now
    )
    it 'has an id' do
      expect(ii.id).to eq(6)
    end
    it 'has an item id' do
      expect(ii.item_id).to eq(7)
    end
    it 'has an invoice id' do
      expect(ii.invoice_id).to eq(8)
    end
    it 'has a quantity' do
      expect(ii.quantity).to eq(1)
    end
    it 'has a unit price' do
      expect(ii.unit_price).to eq(10.99)
    end
  end
  describe 'instances of time' do
    it 'has a time created' do
      allow(Time).to receive(:now) do
        '12:58'
      end
      ii = InvoiceItem.new(
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :cent_price => 1099,
        :created_at => Time.now,
        :updated_at => Time.now
      )
      expect(ii.created_at).to eq('12:58')
    end
    it 'has a time updated' do
      allow(Time).to receive(:now) do
        '12:58'
      end
      ii = InvoiceItem.new(
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :cent_price => 1099,
        :created_at => Time.now,
        :updated_at => Time.now
      )
      expect(ii.updated_at).to eq('12:58')
    end
  end
  describe '#unit_price_to_dollars' do
    ii = InvoiceItem.new(
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :cent_price => 1099,
      :created_at => Time.now,
      :updated_at => Time.now
    )
    it 'converts unit price to dollars' do
      expect(ii.unit_price_to_dollars).to eq(10.99)
    end
  end
end
