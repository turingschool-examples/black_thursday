require 'csv'
require 'simplecov'
require './lib/sales_engine'
require './lib/customer_repo'
require './lib/customer'
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
    results = @engine.customers.all.first
    expect(results).to be_an_instance_of(Customer)
  end

  it 'has attributes' do
    item_1 = @engine.customers.all.first
    expect(item_1.id).to eq(1)
    expect(item_1.last_name).to eq('Ondricka')
    item_1 = @engine.customers.all.last
    expect(item_1.id).to eq(1000)
    expect(item_1.first_name).to eq('Shawn')
    item_1 = @engine.customers.find_by_id(1001)
    expect(item_1).to eq(nil)
  end
end
