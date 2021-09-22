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
    expect(@engine.customers).to be_an_instance_of(CustomerRepository)
  end

  it 'can return all instances of Customer' do
    expect(@engine.customers.all.count).to eq(1000)
  end

  it 'can find customer by id' do
    results = @engine.customers.find_by_id(1)

    expect(results.first_name).to eq('Joey')

    results2 = @engine.customers.find_by_id(1001)
    expect(results2).to eq(nil)
  end

  it 'can find customer by first name' do
    results = @engine.customers.find_all_by_first_name('oe')

    expect(results.length).to eq(8)

    results2 = @engine.customers.find_all_by_first_name('Joey')
    expect(results2.length).to eq(1)
  end

  it 'can find all customers by last name' do
    results = @engine.customers.find_all_by_last_name('Ondricka')

    expect(results.length).to eq(3)

    results2 = @engine.customers.find_all_by_last_name('On')

    expect(results2.length).to eq(85)
  end

  it 'can create a new customer' do
    attributes = {
      first_name: 'cHaz',
      last_name: 'siMons'
    }

    results = @engine.customers.create(attributes)

    expect(results.last.id).to eq(1001)
    expect(results.last.first_name).to eq('Chaz')
  end

  it 'can update existing customers information' do
    attributes = {
      first_name: 'Chaz',
      last_name: 'Simons'
    }

    @engine.customers.update(1, attributes)
    results = @engine.customers.find_by_id(1)

    expect(results.first_name).to eq('Chaz')
    expect(results.last_name).to eq('Simons')
  end

  it 'can delete a customer' do
    @engine.customers.delete(1)

    expect(@engine.customers.all.length).to eq(999)
  end
end
