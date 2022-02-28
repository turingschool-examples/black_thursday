require 'CSV'
require 'simplecov'
require_relative '../lib/customer_repository.rb'
require_relative '../lib/customer.rb'
require_relative '../lib/findable.rb'
require_relative '../lib/crudable.rb'
require_relative '../lib/sales_engine.rb'
SimpleCov.start

RSpec.describe CustomerRepository do
  before :each do
    # @cr = CustomerRepository.new[Customer.new({id: 24, first_name: 'Esteban', last_name:  'Jenkins', created_at:  Time.now, updated_at:  Time.now })]
    @customer_1 = Customer.new({ id: 1, first_name: 'Carl', last_name: 'Carson', created_at: Time.now,
                                 updated_at: Time.now })
    @customer_2 = Customer.new({ id: 2, first_name: 'Becky', last_name: 'Benson', created_at: Time.now,
                                 updated_at: Time.now })
    @customer_3 = Customer.new({ id: 3, first_name: 'Pete', last_name:  'Davidson', created_at: Time.now,
                                 updated_at: Time.now })
    @cr = CustomerRepository.new([@customer_1, @customer_2, @customer_3])
    # @cr = CustomerRepository.new('./data/customer.csv')
  end

  # it 'exists' do
  #   expect(@cr).to be_a(CustomerRepository)
  #   # expect(@cr.all.[23]).to be_an_instance_of(Customer)
  # end

  it 'has attributes' do
    expect(@cr).to be_a(CustomerRepository)
    # expect(@cr.all).to be_a(Array)
  end

  it 'finds a specific customer by id' do
    expect(@cr.find_by_id(1)).to eq(@customer_1)
    expect(@cr.find_by_id(2)).to eq(@customer_2)
    expect(@cr.find_by_id(3)).to eq(@customer_3)
  end

  it 'finds by specific customer first name' do
    expect(@cr.find_all_by_first_name("Carl")).to eq([@customer_1])
    expect(@cr.find_all_by_first_name("Becky")).to eq([@customer_2])
    expect(@cr.find_all_by_first_name("Pete")).to eq([@customer_3])
  end

  it 'finds by specific customer last name' do
    expect(@cr.find_all_by_last_name("Carson")).to eq([@customer_1])
    expect(@cr.find_all_by_last_name("Benson")).to eq([@customer_2])
    expect(@cr.find_all_by_last_name("Davidson")).to eq([@customer_3])
  end

  it 'can create new customer instances' do
    @cr.create({first_name: "Burt", last_name: "Reynolds", created_at: Time.now, updated_at: Time.now})
    expect(@cr.all.length).to eq(4)
    expect(@cr.all.last).to be_a(Customer)
    expect(@cr.all.last.id).to eq(4)
    expect(@cr.all.last.created_at).to be_truthy
    expect(@cr.all.last.updated_at).to be_truthy
  end

  it 'can update Customer instances with attributes' do
    customer_1 = Customer.new({ id: 1, first_name: 'Carl', last_name: 'Carson', created_at: Time.now,
                                 updated_at: Time.now })
    customer_2 = Customer.new({ id: 2, first_name: 'Becky', last_name: 'Benson', created_at: Time.now,
                                 updated_at: Time.now })
    customer_3 = Customer.new({ id: 3, first_name: 'Pete', last_name:  'Davidson', created_at: Time.now,
                                 updated_at: Time.now })
    customer_4 = Customer.new({id: 4, first_name: "Burt", last_name: "Reynolds"})
    cr = CustomerRepository.new([@customer_1, @customer_2, @customer_3, @customer_4])
    cr.update(3, {first_name: "Pete", last_name: "Davidson"})
    expect(customer_3.id).to eq(3)
    expect(customer_3.first_name).to eq("Pete")
    expect(customer_3.last_name).to eq("Davidson")
  end

  it 'can delete Customer instance by id' do
    @cr.delete(2)
    expect(@cr.all).to eq([@customer_1, @customer_3])
    @cr.delete(1)
    expect(@cr.all).to eq([@customer_3])
    @cr.delete(3)
    expect(@cr.all).to eq([])
  end

  it 'initializes #from_csv' do
    se = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv", :customers => "./data/customers.csv" })
    cr = se.customers
    # expect(cr.find_by_id(24).first_name).to eq("Esteban")
  end
end
