require 'csv'
require 'time'
require './lib/customer'
require './lib/customer_repository'
require './lib/sales_engine'

describe CustomerRepository do
  before (:each) do
    @se = SalesEngine.from_csv({
            :items     => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            :invoices => './data/invoices.csv',
            :customers => './data/customers.csv'
                              })
  end
  # customer_rep = CustomerRepository.new('./data/customers.csv')

  it "exists" do
    expect(@se.customers).to be_an_instance_of(CustomerRepository)
  end

  it "can call all Customer class instances" do
    expect(@se.customers.all.length).to eq(1000)
    expect(@se.customers.all[3].class).to be(Customer)
  end

  it "can find an instance of Customer using it's ID" do
    expect(@se.customers.find_by_id(998).first_name).to eq('Clifford')
    expect(@se.customers.find_by_id(552).last_name).to eq('Hauck')
    expect(@se.customers.find_by_id('nothing')).to be_nil
  end

  it "can find all instances of Customers with the same first name" do
    # require 'pry'; binding.pry
    cust = @se.customers.find_all_by_first_name("Lincoln")
    expect(cust.length).to eq(2)
  end

  it "can find all instances of Customers with the same last name" do
     # require 'pry'; binding.pry
    cust = @se.customers.find_all_by_last_name("Schamberger")
    expect(cust.length).to eq(5)
  end

  it "can create a new instance of the customer class" do
     # require 'pry'; binding.pry
    c = ({
      :first_name => "Leopold",
      :last_name => "Schamberger",
      })
    @se.customers.create(c)
    cust = @se.customers.find_by_id(1001)
    expect(cust.class).to eq(Customer)
    expect(cust.first_name).to eq("Leopold")
    expect(cust.last_name).to eq("Schamberger")
    number_of_schambergers =  @se.customers.find_all_by_last_name("Schamberger")
    expect(number_of_schambergers.length).to eq(6)
  end

  it "can update the customer instance with new first and last names" do
    c = ({
      :first_name => "Leopold",
      :last_name => "Schamberger",
      })
    @se.customers.create(c)
    @se.customers.update(1001, "Leo", "Funkhouser")
    cust = @se.customers.find_by_id(1001)
    expect(cust.first_name).to eq("Leo")
    expect(cust.last_name).to eq("Funkhouser")
  end 
end
