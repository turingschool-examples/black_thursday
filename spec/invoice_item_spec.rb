require_relative '../lib/item'
require_relative '../lib/invoice_item'
require 'pry'
require 'BigDecimal'

RSpec.describe InvoiceItem do
  before :each do
  @ii = InvoiceItem.new({
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
    expect(@ii).to be_instance_of InvoiceItem
  end
  it "has an id" do
    expect(@ii.id).to eq(6)
  end
  it "has an item_id" do
    expect(@ii.item_id).to eq(7)
  end
  it "has an invoice_id" do
    expect(@ii.invoice_id).to eq(8)
  end
  it "has a unit_price" do
    expect(@ii.unit_price).to eq(BigDecimal(10.99, 4))
  end
  it "has created_at" do
    expect(@ii.created_at).to be_a Time
  end
  it "has updated_at" do
    expect(@ii.updated_at).to be_a Time
  end
  it "has can convert unit_price to dollars" do
    expect(@ii.unit_price_to_dollars).to eq(10.99)
  end
end
