require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe InvoiceItem do

  before(:each) do
    @paths = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    }
    @se = SalesEngine.from_csv(@paths)
    @ir = @se.invoice_items
  end

  it 'exists' do
    i = InvoiceItem.new({
    :id          => 2345,
    :item_id       => 263562118,
    :invoice_id => 522,
    :quantity  => 9,
    :unit_price  => BigDecimal(84787, 4),
    :created_at  => Time.now,
    :updated_at  => Time.now
    }, @ir)

    expect(i).to be_a(InvoiceItem)
  end

  it 'has attributes' do
    time_stub = '2021-05-30 11:30:51 -0500'
    allow(Time).to receive(:now).and_return(time_stub)

    i = InvoiceItem.new({
      :id          => 2345,
      :item_id       => 263562118,
      :invoice_id => 522,
      :quantity  => 9,
      :unit_price  => BigDecimal(84787, 4),
      :created_at  => Time.now,
      :updated_at  => Time.now
      }, @ir)

    expect(i.id).to eq(2345)
    expect(i.item_id).to eq(263562118)
    expect(i.invoice_id).to eq(522)
    expect(i.quantity).to eq(9)
    expect(i.unit_price).to eq(847.87)
    expect(i.created_at.to_s).to eq(Time.now)
    expect(i.updated_at.to_s).to eq(Time.now)
  end

  it 'stores its states in a hash' do
    time_stub = '2021-05-30 11:30:51.343158 -050'
    allow(Time).to receive(:now).and_return(time_stub)

    i = InvoiceItem.new({
      :id          => 2345,
      :item_id       => 263562118,
      :invoice_id => 522,
      :quantity  => 9,
      :unit_price  => BigDecimal(84787, 4),
      :created_at  => Time.now,
      :updated_at  => Time.now
      }, @ir)
    i_hash = i.to_hash

    expect(i_hash).to be_a(Hash)
    expect(i_hash.keys.length).to eq(7)
    expect(i_hash.values.length).to eq(7)
    expect(i_hash[:id]).to eq(i.id)
    expect(i_hash[:item_id]).to eq(i.item_id)
    expect(i_hash[:invoice_id]).to eq(i.invoice_id)
    expect(i_hash[:quantity]).to eq(i.quantity)
    expect(i_hash[:unit_price]).to eq(i.unit_price)
    expect(i_hash[:created_at]).to eq(i.created_at)
    expect(i_hash[:updated_at]).to eq(i.updated_at)
  end

  it 'can convert unit price into dollars' do
    i = InvoiceItem.new({
      :id          => 2345,
      :item_id       => 263562118,
      :invoice_id => 522,
      :quantity  => 9,
      :unit_price  => BigDecimal(84787, 4),
      :created_at  => Time.now,
      :updated_at  => Time.now
      }, @ir)

    expect(i.unit_price_to_dollars).to eq(847.87)
  end

end
