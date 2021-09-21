require './lib/customerrepository'
require './lib/customer'
require './lib/item'
require './lib/itemrepository'
require './lib/merchant'
require './lib/merchantrepository'
require './lib/invoice'
require './lib/invoicerepository'
require './lib/invoice_item'
require './lib/invoice_item_repo'
require 'bigdecimal'
require 'bigdecimal/util'
require 'objspace'
require './lib/sales_engine'
require 'csv'
require 'rspec'

describe CustomerRepository do
  it 'exists' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    customer = se.customers

    expect(customer).to be_a(CustomerRepository)
  end

  it 'finds all instances' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    customer = se.customers

    expect(customer.all.count).to eq(1000)
  end

  it 'finds by id' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    customer = se.customers
    c1 = customer.find_by_id(26)

    expect(c1.last_name).to eq("Sawayn")
  end

  it 'finds by first name' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    customer = se.customers
    c1 = customer.find_all_by_first_name("j")

    expect(c1.count).to eq(72)
  end

  it 'finds by last name' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    customer = se.customers
    c1 = customer.find_all_by_last_name("m")

    expect(c1.count).to eq(202)
  end

  it "can create a new invoice item with max_id being +1" do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    customer = se.customers

    attributes = {
                  :id           => 10,
                  :first_name   => "Ramona",
                  :last_name    => "Reynolds",
                  :created_at   => "2012-03-27 14:54:11 UTC",
                  :updated_at   => "2012-03-27 14:54:11 UTC"
                  }

    expect(customer.all.length).to eq(1000)
    customer.create(attributes)
    expect(customer.all.length).to eq(1001)
  end

  it "can update attributes" do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    customer = se.customers

    attribute = {
                  :id           => 10,
                  :first_name   => "Ramona",
                  :last_name    => "Reynolds",
                  :created_at   => "2012-03-27 14:54:11 UTC",
                  :updated_at   => "2012-03-27 14:54:11 UTC"
                  }

    results = {
                  :id           => 10,
                  :first_name   => "Ramona",
                  :last_name    => "Reynolds",
                  :created_at   => "2012-03-27 14:54:11 UTC",
                  :updated_at   => Time.now
                  }

  customer_results = Customer.new(results)

  expect(customer.update(10, attribute).first_name).to eq(customer_results.first_name)
  expect(customer.update(10, attribute).last_name).to eq(customer_results.last_name)
  end

  it 'deletes a customer' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    customer = se.customers

    expect(customer.delete(300).length).to eq(999)
  end
end
