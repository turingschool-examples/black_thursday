require 'rspec'
require './lib/invoice_items'
require 'bigdecimal'
require 'pry'

describe InvoiceItems do
  before (:each) do
    @ii = InvoiceItems.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
  end

  it "exists" do
    expect(@ii).to be_an_instance_of(InvoiceItems)
  end

  it "has an id" do
    expect(@ii.id).to eq(6)
  end

  it "has an item id" do
    expect(@ii.item_id).to eq(7)
  end

  it "has an invoice id" do
    expect(@ii.invoice_id).to eq(8)
  end

  it "has a quantity" do
    expect(@ii.quantity).to eq(1)
  end

  it "has a unit price" do
    expect(@ii.unit_price).to eq(BigDecimal(10.99, 4))
  end

  it "returns a unit price in dollars" do
    expect(@ii.unit_price_to_dollars).to eq(10.99)
  end

end
