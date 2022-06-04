require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe InvoiceItem do
  let!(:time) {Time.now}
  let!(:invoice_item) {InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
  })}

  it "exists" do
    expect(invoice_item).to be_instance_of InvoiceItem
  end

  xit 'returns id' do
    expect(invoice_item.id).to eq(5)
  end

  xit 'returns name' do
    expect(invoice_item.name).to eq("Turing School")
  end
end
