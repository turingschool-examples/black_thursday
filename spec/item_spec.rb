require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe Item do

  before(:each) do
    @paths = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    }
    @se = SalesEngine.from_csv(@paths)
    @ir = @se.items
  end

  it 'exists' do
    i = Item.new({
    :id          => 1,
    :name        => 'Pencil',
    :description => 'You can use it to write things',
    :unit_price  => BigDecimal(10.99, 4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 2
    }, @ir)

    expect(i).to be_a(Item)
  end

  it 'has attributes' do
    time_stub = '2021-05-30 11:30:51 -0500'
    allow(Time).to receive(:now).and_return(time_stub)

    i = Item.new({
    :id          => 1,
    :name        => 'Pencil',
    :description => 'You can use it to write things',
    :unit_price  => BigDecimal(10.99, 4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 2
    }, @ir)

    expect(i.id).to eq(1)
    expect(i.name).to eq('Pencil')
    expect(i.description).to eq('You can use it to write things')
    expect(i.unit_price).to eq((BigDecimal(10.99, 4)) / 100)
    expect(i.merchant_id).to eq(2)
    expect(i.created_at.to_s).to eq(Time.now)
    expect(i.updated_at.to_s).to eq(Time.now)
  end

  it 'stores its states in a hash' do
    time_stub = '2021-05-30 11:30:51.343158 -050'
    allow(Time).to receive(:now).and_return(time_stub)

    i = Item.new({
    :id          => 1,
    :name        => 'Pencil',
    :description => 'You can use it to write things',
    :unit_price  => BigDecimal(10.99, 4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 2
    }, @ir)
    i_hash = i.to_hash

    expect(i_hash).to be_a(Hash)
    expect(i_hash.keys.length).to eq(7)
    expect(i_hash.values.length).to eq(7)
    expect(i_hash[:id]).to eq(i.id)
    expect(i_hash[:name]).to eq(i.name)
    expect(i_hash[:description]).to eq(i.description)
    expect(i_hash[:unit_price]).to eq(i.unit_price)
    expect(i_hash[:created_at]).to eq(i.created_at)
    expect(i_hash[:updated_at]).to eq(i.updated_at)
  end

  it 'can convert unit price into dollars' do

    i = Item.new({
    :id          => 1,
    :name        => 'Pencil',
    :description => 'You can use it to write things',
    :unit_price  => BigDecimal(10.99, 4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 2
    }, @ir)

    expect(i.unit_price_to_dollars).to eq(10.99 / 100)
  end

end
