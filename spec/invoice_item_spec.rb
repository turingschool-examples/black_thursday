require './lib/invoice_item'
require 'BigDecimal'

RSpec.describe InvoiceItem do

  it 'exists' do
    ii = InvoiceItem.new({
      :id => 263519844,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

    expect(ii.new).to be_a(InvoiceItem)
  end

  it 'returns the integer id'
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

    expect(ii.id).to eq(6)
  end

  it 'returns the item id' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

    expect(ii.item_id).to eq(8)
  end

  it 'returns the invoice id' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

    expect(ii.invoice_id).to eq(8)
  end

  it 'returns the quantity' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

    expect(ii.quantity).to eq(1)
  end

  it 'returns the unit price' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

    expect(ii.unit_price).to eq(BigDecimal(10.99, 4))
  end

  it 'returns a Time instance for the date when invoice item was created' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

    expect(ii.created_at).to eq(Time.now.round)
  end

  it 'returns a Time instance for the date when invoice item was updated' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

    expect(ii.updated_at).to eq(Time.now.round)
  end

  it 'returns the price of the invoice item in dollars formated as a float' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

    expect(ii.unit_price_to_dollars).to eq(10.99)
  end
end
