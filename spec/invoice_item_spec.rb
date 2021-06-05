require_relative 'spec_helper'
require_relative '../lib/invoice_item'
require 'bigdecimal'

RSpec.describe InvoiceItem do
  before (:each) do
    @time = Time.now
    @ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal(10.99, 4),
  :created_at => @time,
  :updated_at => @time
  }, nil)
  end

  it 'exists' do
    expect(@ii).to be_a(InvoiceItem)
  end

  it 'attributes' do
    expect(@ii.id).to eq(6)
    expect(@ii.item_id).to eq(7)
    expect(@ii.invoice_id).to eq(8)
    expect(@ii.quantity).to eq(1)
    expect(@ii.unit_price).to eq(0.1099e2)
    expect(@ii.created_at).to eq(@time)
    expect(@ii.updated_at).to eq(@time)
    expect(@repo).to eq(nil)
  end

  it '.unit_price_to_dollars' do
    expect(@ii.unit_price_to_dollars).to eq(10.99)
  end
end
