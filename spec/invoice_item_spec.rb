require "./lib/invoice_item"
require "bigdecimal"
require "time"

RSpec.describe "InvoiceItem" do
  ii = InvoiceItem.new({
    id: 6,
    item_id: 7,
    invoice_id: 8,
    unit_price: BigDecimal("10.99", 4),
    created_at: Time.now,
    updated_at: Time.now,
  })

  it "exists" do
    expect(ii).to be_an_instance_of(InvoiceItem)
  end

#   it "has all expected attributes" do
#     expect(item.item_attributes[:id]).to eq(1)
#     expect(item.item_attributes[:name]).to eq("Pencil")
#     expect(item.item_attributes[:description]).to eq("You can use it to write things")
#     expect(item.item_attributes[:unit_price]).to eq(BigDecimal("10.99", 4))
#     expect(item.item_attributes[:created_at]).to be_an_instance_of(Time)
#     expect(item.item_attributes[:updated_at]).to be_an_instance_of(Time)
#     expect(item.item_attributes[:merchant_id]).to eq(2)
#   end
#
#   it "can convert unit price to dollars" do
#     expect(item.unit_price_to_dollars).to eq(10.99)
#   end
# end
