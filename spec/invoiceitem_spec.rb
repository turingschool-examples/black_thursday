require './lib/invoiceitem'
require 'bigdecimal'

RSpec.describe do
  it "exists" do
    ii = InvoiceItem.new({
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      })

    expect(ii).to be_an_instance_of(InvoiceItem)
  end

  it "returns an integer id" do
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
    expect(ii.id).to be_an(Integer)
  end

  it "has attributes" do
    ii = InvoiceItem.new({
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99,4),
        :created_at => Time.now,
        :updated_at => Time.now
      })
    expect(ii.item_id).to eq(7)
    expect(ii.item_id).to be_an(Integer)
    expect(ii.invoice_id).to eq(8)
    expect(ii.invoice_id).to be_an(Integer)
    expect(ii.quantity).to eq(1)
    expect(ii.unit_price).to eq(BigDecimal(10.99,4))
    expect(ii.created_at).to be_an_instance_of(Time)
    expect(ii.updated_at).to be_an_instance_of(Time)
  end

  it "returns invoice item price in dollars" do
    ii = InvoiceItem.new({
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99,4),
        :created_at => Time.now,
        :updated_at => Time.now
        })
    expect(ii.unit_price_to_dollars).to be_a(Float)
    expect(ii.unit_price_to_dollars).to eq(10.99)
  end
end
