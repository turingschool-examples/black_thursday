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
                                     invoices: './data/invoices.csv',
                                     invoice_items: './data/invoice_items.csv',
                                     customers: './data/customers.csv',
                                     transactions: './data/transactions.csv'
                                   })
  end

  it 'exists' do
    results = @engine.invoice_items.all.first
    expect(results).to be_an_instance_of(InvoiceItem)
  end

  it 'has attributes' do
    item_1 = @engine.invoice_items.all.first
    expect(item_1.id).to eq(1)
    expect(item_1.quantity).to eq(5)
    item_1 = @engine.invoice_items.all.last
    expect(item_1.id).to eq(21_830)
    expect(item_1.invoice_id).to eq(4985)
    item_1 = @engine.invoice_items.find_by_id(21_831)
    expect(item_1).to eq(nil)
  end
end
