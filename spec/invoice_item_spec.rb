require_relative '../lib/invoice_item.rb'

RSpec.describe InvoiceItem do

  it 'exists' do
    ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal(10.99, 4),
  :created_at => Time.now.to_s,
  :updated_at => Time.now.to_s
    })

    expect(ii).to be_a(InvoiceItem)
  end

  it 'has an id' do
    ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal(10.99, 4),
  :created_at => Time.now.to_s,
  :updated_at => Time.now.to_s
    })

    expect(ii.id).to eq(6)
  end

  it 'has an item_id' do
    ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal(10.99, 4),
  :created_at => Time.now.to_s,
  :updated_at => Time.now.to_s
    })

    expect(ii.item_id).to eq(7)
  end

  it 'has an invoice_id' do
    ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal(10.99, 4),
  :created_at => Time.now.to_s,
  :updated_at => Time.now.to_s
    })

    expect(ii.invoice_id).to eq(8)
  end

  it 'has a quantity' do
    ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal(10.99, 4),
  :created_at => Time.now.to_s,
  :updated_at => Time.now.to_s
    })

    expect(ii.quantity).to eq(1)
  end

  it 'has a unit_price' do
    ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => 1099,
  :created_at => Time.now.to_s,
  :updated_at => Time.now.to_s
    })

    expect(ii.unit_price).to eq(0.1099e2)
  end

  it 'has a created at time' do
    ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal(10.99, 4),
  :created_at => created = Time.now.to_s,
  :updated_at => Time.now.to_s
    })

    expect(ii.created_at).to eq Time.parse(created)
  end

  it 'has a updated at time' do
    ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal(10.99, 4),
  :created_at => Time.now.to_s,
  :updated_at => updated = Time.now.to_s
    })

    expect(ii.updated_at).to eq Time.parse(updated)
  end

  it 'can convert unit price to dollars' do
    ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => 1099,
  :created_at => Time.now.to_s,
  :updated_at => Time.now.to_s
    })

    expect(ii.unit_price_to_dollars).to eq (10.99)
  end
end
