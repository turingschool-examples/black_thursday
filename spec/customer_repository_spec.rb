require_relative '../lib/customer_repository'
require './lib/sales_engine'

RSpec.describe CustomerRepository do
  it 'exists and has no customers by default' do
    cust = CustomerRepository.new

    expect(cust).to be_a(CustomerRepository)
    expect(cust.customers).to eq([])
  end

  it 'can find customers by id' do
    se = SalesEngine.from_csv({:customers => "./data/customers.csv"})
    cust_id = 6
    expect(se.customers.find_by_id(cust_id)).to be_a (Customer)
    expect(se.customers.find_by_id(cust_id)).to eq (se.customers.customers.find {|customer| customer.id == cust_id})
  end

  # all - returns an array of all known Customer instances
  xit 'returns an array of all known Customer instances' do
    se = SalesEngine.from_csv({:customers => "./data/customers.csv"})
    expect(se.customers.customers.class).to eq (Array)
    expect(se.customers.customers.length).to eq ()
  end

  # find_by_id - returns either nil or an instance of Customer with a matching ID
  # find_all_by_first_name - returns either [] or one or more matches which have a first name matching the substring fragment supplied
  # find_all_by_last_name - returns either [] or one or more matches which have a last name matching the substring fragment supplied
  # create(attributes) - create a new Customer instance with the provided attributes. The new Customer’s id should be the current highest Customer id plus 1.
  # update(id, attribute) - update the Customer instance with the corresponding id with the provided attributes. Only the customer’s first_name and last_name can be updated. This method will also change the customer’s updated_at attribute to the current time.
  #delete(id) - delete the Customer instance with the corresponding id
end