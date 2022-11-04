require_relative '../lib/customer_repository'
require './lib/sales_engine'

RSpec.describe CustomerRepository do
  it 'exists and has no customers by default' do
    cust = CustomerRepository.new

    expect(cust).to be_a(CustomerRepository)
    expect(cust.customers).to eq([])
  end

  # find_by_id - returns either nil or an instance of Customer with a matching ID
  it 'can find customers by id' do
    se = SalesEngine.from_csv({:customers => "./data/customers.csv"})

    expect(se.customers.find_by_id(0)).to eq (nil)
    expect(se.customers.find_by_id(6)).to be_a (Customer)
    expect(se.customers.find_by_id(6).first_name).to eq ("Heber")
  end

  # all - returns an array of all known Customer instances
  it 'returns an array of all known Customer instances' do
    se = SalesEngine.from_csv({:customers => "./data/customers.csv"})
    # require 'pry'; binding.pry
    expect(se.customers.all).to be_a(Array)
    expect(se.customers.all.first).to be_a(Customer) 
  end
  # find_all_by_first_name - returns either [] or one or more matches which have a first name matching the substring fragment supplied
  it 'finds all by first name -if first name does not exist returns nil' do
    se = SalesEngine.from_csv({:customers => "./data/customers.csv"})

    expect(se.customers.find_all_by_first_name("Coopernicus")).to eq []
    # require 'pry'; binding.pry
    expect(se.customers.find_all_by_first_name("Lisa")).to eq ([se.customers.all[60], se.customers.all[66], se.customers.all[599], se.customers.all[646]])
    expect(se.customers.find_all_by_first_name("oe")).to eq ([se.customers.all[0], se.customers.all[191], se.customers.all[308], se.customers.all[446], se.customers.all[504], se.customers.all[567], se.customers.all[588], se.customers.all[823]])
  end
  
  # find_all_by_last_name - returns either [] or one or more matches which have a last name matching the substring fragment supplied
  it 'finds all by last name -if last name does not exist returns nil' do
    se = SalesEngine.from_csv({:customers => "./data/customers.csv"})

    expect(se.customers.find_all_by_last_name("Schnickelfritz")).to eq []
    expect(se.customers.find_all_by_last_name("Fadel")[0]).to eq (se.customers.all[8])
    expect(se.customers.find_all_by_last_name("On").length).to eq 85

  end
  
  # create(attributes) - create a new Customer instance with the provided attributes. The new Customer’s id should be the current highest Customer id plus 1.
  it 'creates a new Customer instance with provided attributes' do
    se = SalesEngine.from_csv({:customers => "./data/customers.csv"})
    se.customers.create({
      :id         => se.customers.customers.length + 1,
      :first_name => "Monty",
      :last_name  => "Python",
      :created_at => Time.now,
      :updated_at => Time.now
    })

    expect(se.customers.all.last.first_name).to eq ("Monty")
    expect(se.customers.all.last.last_name).to eq ("Python")
    expect(se.customers.all.last.id).to eq (1001)
  end
  
  # update(id, attribute) - update the Customer instance with the corresponding id with the provided attributes. Only the customer’s first_name and last_name can be updated. This method will also change the customer’s updated_at attribute to the current time.
  it 
  #delete(id) - delete the Customer instance with the corresponding id
  it 'deletes a Customer instance with provided id' do
    se = SalesEngine.from_csv({:customers => "./data/customers.csv"})

    expect(se.customers.all[9].last_name).to eq ("Reynolds")
    se.customers.delete(10)
    expect(se.customers.find_by_id(10)).to eq(nil)
  end
end