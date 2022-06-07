require './lib/helper'
SimpleCov.start

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

  it 'returns unit price' do
    expect(invoice_item.unit_price).to eq(10.99)
  end

  it "can return the time the invoice_item was created" do
    expect(invoice_item.created_at.strftime("%Y-%m-%d %H:%M")).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end

  it "can return the time the object was updated" do
    expect(invoice_item.updated_at.strftime("%Y-%m-%d %H:%M")).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end

  xit "can return the unit price converted to dollars" do
    expect(invoice_item.unit_price_to_dollars).to eq(10.99)
  end
end
