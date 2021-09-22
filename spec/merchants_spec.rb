# frozen_string_literal: true

require 'csv'
require 'time'
require './lib/sales_engine'

RSpec.describe Merchant do
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

  it 'has attributes' do
    item_1 = @engine.merchants.all.first
    expect(item_1.id).to eq(12_334_105)
    expect(item_1.name).to eq('Shopin1901')
    item_1 = @engine.merchants.all.last
    expect(item_1.id).to eq(12_337_411)
    expect(item_1.name).to eq('CJsDecor')
  end
end
