<<<<<<< HEAD
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
=======
require "./lib/invoice_item"
require "bigdecimal"
require "Rspec"

RSpec.describe InvoiceItem do


  it 'exists' do
    data = ({:id => 1,
    :item_id => 263519844,
    :invoice_id => 1,
    :quantity => 5,
    :unit_price  => 13635,
    :created_at  => Time.now,
    :updated_at  => Time.now})

    invoiceitem = InvoiceItem.new(data)
    expect(invoiceitem).to be_an_instance_of(InvoiceItem)
  end

  it "can return the details of an invoice id" do
    data = ({:id => 1,
    :item_id => 263519844,
    :invoice_id => 1,
    :quantity => 5,
    :unit_price  => 13635,
    :created_at  => Time.now.round,
    :updated_at  => Time.now.round})

    invoiceitem = InvoiceItem.new(data)
    expect(invoiceitem.id).to eq(1)
    expect(invoiceitem.item_id).to eq(263519844)
    expect(invoiceitem.quantity).to eq(5)
    expect(invoiceitem.created_at).to eq(Time.now.round)
    expect(invoiceitem.updated_at).to eq(Time.now.round)
  end

  it "can return the unit price as a float" do
    data = ({:id => 1,
    :item_id => 263519844,
    :invoice_id => 1,
    :quantity => 5,
    :unit_price  => 13635,
    :created_at  => Time.now,
    :updated_at  => Time.now})

    invoiceitem = InvoiceItem.new(data)
    expect(invoiceitem.unit_price_to_dollars).to eq(13635.0)
>>>>>>> af42e2a0c22e9a8ac8fc8faaa6957846608d9c4d
  end
end
