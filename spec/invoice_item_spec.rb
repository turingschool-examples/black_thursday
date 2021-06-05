require_relative 'spec_helper'
require_relative '../lib/invoice_item'
require 'bigdecimal'

RSpec.describe InvoiceItem do
  before (:each) do
    @time = Time.now
    @repo = double('repo')
    @attributes = {
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => @time,
      :updated_at => @time
      }
    @ii = InvoiceItem.new(@attributes, @repo)
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
    expect(@ii.repo).to eq(@repo)
  end

  it '.unit_price_to_dollars' do
    expect(@ii.unit_price_to_dollars).to eq(10.99)
  end

  it 'can create new invoice items' do
    attributes = {
      :item_id => 21,
      :invoice_id => 3,
      :quantity => 20,
      :unit_price => BigDecimal(11.99, 4),
      }

    allow(@repo).to receive(:new_invoice_item_id).and_return(7)
    expect(InvoiceItem.create_invoice_item(attributes, @repo)).to be_a(InvoiceItem)
  end
end
