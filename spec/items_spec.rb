# frozen_string_literal: true

require 'csv'
require 'time'
require './lib/sales_engine'

RSpec.describe Item do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                     items: './data/items.csv',
                                     merchants: './data/merchants.csv',
                                     invoices: './data/invoices.csv',
                                     invoice_items: './data/invoice_items.csv',
                                     customers: './data/customers.csv',
                                     transactions: './data/transactions.csv'
                                   })
  end

  it 'can return the item id' do
    item_1 = @engine.items.all.first
    expect(item_1.id).to eq 263_395_237

    item_2 = @engine.items.all.last
    expect(item_2.id).to eq 263_567_474
  end

  it 'can return the item name' do
    item_1 = @engine.items.all.first
    expect(item_1.name).to eq('510+ RealPush Icon Set')

    item_2 = @engine.items.all.last
    expect(item_2.name).to eq('Minty Green Knit Crochet Infinity Scarf')
  end

  it 'can return the item description' do
    item_1 = @engine.items.all.first

    expect(item_1.description).to be_a(String)
    expect(item_1.description.length).to eq(2236)
  end

  it 'can return the items unit price' do
    item_1 = @engine.items.all.first

    expect(item_1.unit_price).to eq 12.00
    expect(item_1.unit_price).to be_a(BigDecimal)
  end

  it 'can return the merchant_id' do
    item_1 = @engine.items.all.first

    expect(item_1.merchant_id).to eq(12_334_141)
  end

  it 'can return the Time the item was created' do
    item_1 = @engine.items.all.first

    expect(item_1.created_at).to eq Time.parse('2016-01-11 09:34:06 UTC')
    expect(item_1.created_at.class).to eq(Time)
  end

  it 'it can return unit price in dollars' do
    item_1 = @engine.items.all.first

    expect(item_1.unit_price_to_dollars).to eq(12.0)
  end
end
