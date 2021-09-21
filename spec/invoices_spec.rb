require 'csv'
require 'simplecov'
require './lib/sales_engine'
require './lib/invoices'
require './lib/invoice_repo'
SimpleCov.start

RSpec.describe do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                     items: './data/items.csv',
                                     merchants: './data/merchants.csv',
                                     invoices: "./data/invoices.csv",
                                     invoice_items: './data/invoice_items.csv',
                                     customers: './data/customers.csv',
                                     transactions: './data/transactions.csv'
                                   })
  end

  it 'exists' do
    results = @engine.invoices.all.first
    expect(results).to be_an_instance_of(Invoice)
  end

  it 'has attributes' do
    item_1 = @engine.invoices.all.first
    expect(item_1.id).to eq(1)
    expect(item_1.status).to eq(:pending)
    item_1 = @engine.invoices.all.last
    expect(item_1.id).to eq(4985)
    expect(item_1.customer_id).to eq(999)
    item_1 = @engine.invoices.find_by_id(4986)
    expect(item_1).to eq(nil)
  end
end
