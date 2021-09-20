require 'csv'
require 'simplecov'
require './lib/sales_engine'
require './lib/invoice_item_repo'
require './lib/invoice_item'
SimpleCov.start

RSpec.describe do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                     items: './data/items.csv',
                                     merchants: './data/merchants.csv',
                                     invoices: "./data/invoices.csv",
                                     invoice_items: './data/invoice_items.csv'
                                   })
  end

  it 'exists' do
    expect(@engine.invoice_items).to be_an_instance_of(InvoiceItemRepository)
  end

  it 'returns all known InvoiceItem instances' do
    expect(@engine.invoice_items.all.count).to eq(21830)
  end

  it 'can find invoiceitem by id' do
    results = @engine.invoice_items.find_by_id(1)

    expect(results.item_id).to eq(263519844)
  end

  it 'can find all by an item_id' do
    results = @engine.invoice_items.find_all_by_item_id(263519844)

    expect(results.count).to eq(164)
  end
end
