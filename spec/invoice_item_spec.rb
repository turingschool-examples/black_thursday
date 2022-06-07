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
    :created_at  => Time.now,
    :updated_at  => Time.now})

    invoiceitem = InvoiceItem.new(data)
  end
end
