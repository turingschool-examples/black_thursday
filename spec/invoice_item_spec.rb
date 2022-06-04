require './lib/invoice_item'

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
    expect(@ii).to be_a(InvoiceItem)
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

  it "has a quantity" do
    expect(@ii.quantity).to eq(1)
  end

  it "has a unit_price" do
    expect(@ii.unit_price).to be_a(BigDecimal)
  end

  it "has created_at" do
    expect(@ii.created_at).to be_a(Time)
  end

  it "has updated_at" do
    expect(@ii.updated_at).to be_a(Time)
  end

  it "can turn unit_price_to_dollars" do
    expect(@ii.unit_price_to_dollars).to eq(10.99)
    expect(@ii.unit_price_to_dollars).to be_a(Float)
  end

end
