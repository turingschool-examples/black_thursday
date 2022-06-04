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

  it 'returns id' do
    expect(invoice_item.id).to eq(6)
  end

  it 'returns item id' do
    expect(invoice_item.item_id).to eq(7)
  end

  it 'returns invoice id' do
    expect(invoice_item.invoice_id).to eq(8)
  end

  it 'returns quantity' do
    expect(invoice_item.quantity).to eq(1)
  end

  xit 'returns unit price' do
    expect(invoice_item.invoice_id).to eq(8)
  end
end
