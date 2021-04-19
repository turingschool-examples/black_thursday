require 'rspec'
require './lib/invoice_item'
require 'bigdecimal'
require 'time'

describe InvoiceItem do
  describe '#initialize' do
    it 'exists' do
      ii_details = {
        id: 6,
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now
      }
      invoice_item = InvoiceItem.new(ii_details)

      expect(invoice_item).is_a? InvoiceItem
    end

    it 'returns the integer id' do
      ii_details = {
        id: 6,
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now
      }
      invoice_item = InvoiceItem.new(ii_details)

      expect(invoice_item.id).to eq 6
      expect(invoice_item.id).is_a? Integer
    end

    it 'returns the item id' do
      ii_details = {
        id: 6,
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now
      }
      invoice_item = InvoiceItem.new(ii_details)

      expect(invoice_item.item_id).to eq 7
      expect(invoice_item.item_id).is_a? Integer
    end

    it 'returns the invoice id' do
      ii_details = {
        id: 6,
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now
      }
      invoice_item = InvoiceItem.new(ii_details)

      expect(invoice_item.invoice_id).to eq 8
      expect(invoice_item.invoice_id).is_a? Integer
    end

    it 'returns the quantity' do
      ii_details = {
        id: 6,
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now
      }
      invoice_item = InvoiceItem.new(ii_details)

      expect(invoice_item.quantity).to eq 1
    end

    it 'returns the unit price' do
      ii_details = {
        id: 6,
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: '1099',
        created_at: Time.now,
        updated_at: Time.now
      }
      invoice_item = InvoiceItem.new(ii_details)

      expect(invoice_item.unit_price).to eq BigDecimal(10.99, 4)
      expect(invoice_item.unit_price).is_a? BigDecimal
    end

    it 'returns a Time instance for date invoice_item was created' do
      ii_details = {
        id: 6,
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: '1099',
        created_at: Time.parse('2007-06-04 21:35:10 UTC'),
        updated_at: Time.now
      }
      invoice_item = InvoiceItem.new(ii_details)

      expect(invoice_item.created_at).to eq(Time.parse('2007-06-04 21:35:10 UTC'))
      expect(invoice_item.created_at).is_a? Time
    end

    it 'returns a Time instance for date invoice_item updated' do
      ii_details = {
        id: 6,
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.parse('2007-06-04 21:35:10 UTC')
      }
      invoice_item = InvoiceItem.new(ii_details)

      expect(invoice_item.updated_at).to eq(Time.parse('2007-06-04 21:35:10 UTC'))
      expect(invoice_item.updated_at).is_a? Time
    end
  end

  describe '#unit price to dollars' do
    it 'returns the price of the invoice_item in dollars as Float' do
      ii_details = {
        id: 6,
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: '1099',
        created_at: Time.now,
        updated_at: Time.now
      }
      invoice_item = InvoiceItem.new(ii_details)

      expect(invoice_item.unit_price_to_dollars).is_a? Float
      expect(invoice_item.unit_price_to_dollars).to eq 10.99
    end
  end
end
