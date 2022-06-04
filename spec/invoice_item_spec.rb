require 'BigDecimal'
require './lib/invoice_item'

RSpec.describe InvoiceItem do
  it "exists and has attributes" do
    invoice_item = InvoiceItem.new(
    {
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    }
  )
    expect(invoice_item).to be_a(InvoiceItem)
    expect(invoice_item.id).to eq(6)
    expect(invoice_item.item_id).to eq(7)
    expect(invoice_item.invoice_id).to eq(8)
    expect(invoice_item.quantity).to eq(1)
    expect(invoice_item.unit_price).to eq(BigDecimal(10.99, 4))
    expect(invoice_item.created_at).to be_a(Time)
    expect(invoice_item.updated_at).to be_a(Time)
  end
end
