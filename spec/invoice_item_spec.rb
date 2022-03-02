require "./lib/invoice_item"
require "./lib/sales_engine"
require "bigdecimal"
require "Time"

RSpec.describe "InvoiceItem" do
  let(:ii) do
    InvoiceItem.new({
      id: 6,
      item_id: 7,
      invoice_id: 8,
      quantity: 1,
      unit_price: BigDecimal("10.99", 4),
      created_at: Time.now,
      updated_at: Time.now
    })
  end

  it "exists" do
    expect(ii).to be_an_instance_of(InvoiceItem)
  end

  it "has expected attributes" do
    expect(ii.invoice_item_attributes[:id]).to eq(6)
    expect(ii.invoice_item_attributes[:item_id]).to eq(7)
    expect(ii.invoice_item_attributes[:invoice_id]).to eq(8)
    expect(ii.invoice_item_attributes[:quantity]).to eq(1)
    expect(ii.invoice_item_attributes[:unit_price]).to eq(BigDecimal("10.99", 4))
    expect(ii.invoice_item_attributes[:created_at]).to be_an_instance_of(Time)
    expect(ii.invoice_item_attributes[:updated_at]).to be_an_instance_of(Time)
  end

  it "can convert unit price to dollars" do
    expect(ii.unit_price_to_dollars).to eq(10.99)
  end
end
