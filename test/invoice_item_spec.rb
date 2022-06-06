require "./lib/sales_engine"
require "./lib/sales_analyst"
require "./lib/invoice_item"
require "./lib/invoice_item_repository"

RSpec.describe InvoiceItem do
  let(:invoice_item) {InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal(10.99, 4),
  :created_at => Time.now.round,
  :updated_at => Time.now.round
  })}

  it "exists" do
    expect(invoice_item).to be_an(InvoiceItem)
  end

  it "has attributes" do
    expect(invoice_item.id).to eq(6)
    expect(invoice_item.item_id).to eq(7)
    expect(invoice_item.invoice_id).to eq(8)
    expect(invoice_item.quantity).to eq(1)
    expect(invoice_item.unit_price).to be_a(BigDecimal)
    expect(invoice_item.created_at).to eq(Time.now.round)
    expect(invoice_item.updated_at).to eq(Time.now.round)
  end

  it "has unit price to dollars" do
    expect(invoice_item.unit_price_to_dollars).to eq(10.99)
  end
end
