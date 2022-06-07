require './lib/merchant'
require './lib/merchant_repository'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/invoice_item'
require './lib/invoice_item_repository'
require './lib/transaction'
require './lib/transaction_repository'
require './lib/customer'
require './lib/customer_repository'

describe CustomerRepository do
  let(:sales_engine) {SalesEngine.from_csv({
     :items     => "./data/items.csv",
     :merchants => "./data/merchants.csv",
     :invoices => "./data/invoices.csv",
     :invoice_items => "./data/invoice_items.csv",
     :transactions => "./data/transactions.csv",
     :customers => "./data/customers.csv"
     })}
  let(:customer) {sales_engine.customers}


  it "exists" do
    expect(customer).to be_a(CustomerRepository)
  end

  it "has attributes" do
    expect(customer.all).to be_an(Array)
    expect(customer.all.first.id).to eq(1)
    expect(customer.all.first.first_name).to eq("Joey")
    expect(customer.all.first.last_name).to eq("Ondricka")
    expect(customer.all.first.created_at).to eq(Time.parse("2012-03-27 14:54:09 UTC"))
    expect(customer.all.first.updated_at).to eq(Time.parse("2012-03-27 14:54:09 UTC"))
  end

  it "can find a customer by id" do
    expect(customer.find_by_id(1).first_name).to eq("Joey")
    expect(customer.find_by_id(1).last_name).to eq("Ondricka")
    expect(customer.find_by_id(5000)).to eq(nil)
  end

  it "can find all customers by first names" do
    expect(customer.find_all_by_first_name("Heber")).to be_a(Array)
    expect(customer.find_all_by_first_name("Heber").count).to eq(1)
    expect(customer.find_all_by_first_name("Yeezy")).to eq([])
  end

  it "can find all customers by last names" do
    expect(customer.find_all_by_last_name("Kuhn")).to be_a(Array)
    expect(customer.find_all_by_last_name("Kuhn").count).to eq(3)
    expect(customer.find_all_by_last_name("Yeezy")).to eq([])
  end

  it 'can create a new customer' do
    attributes = {
        :id => 1001,
        :first_name => 'Ye',
        :last_name => 'Ye',
        :created_at  => Time.now,
        :updated_at  => Time.now,
      }
    customer.create(attributes)
    expect(customer.all.length).to eq(1001)
  end

  it 'can update a customer' do
    attributes = {:first_name=> "Jack"}
    attributes1 = {:last_name=> "Smith"}
    customer.update(1000, attributes)
    expect(customer.all.last.first_name).to eq("Jack")
    customer.update(1, attributes1)
    expect(customer.all.first.last_name).to eq("Smith")
  end

  it 'can delete by id' do
    customer.delete(300)
    expect(customer.all.length).to eq(999)
  end
end
