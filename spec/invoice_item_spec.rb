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
  end
end
