require 'CSV'
require 'simplecov'
require_relative '../lib/customer_repository.rb'
require_relative '../lib/customer.rb'
require_relative '../lib/sales_engine.rb'
SimpleCov.start

RSpec.describe CustomerRepository do
  before :each do
    @cr = CustomerRepository.new[Customer.new({id: 24, first_name: 'Esteban', last_name:  'Jenkins', created_at:  Time.now, updated_at:  Time.now })]
    @customer_1 = Customer.new({id: 1, first_name: 'Carl', last_name:  'Carson', created_at:  Time.now, updated_at:  Time.now })
    @customer_2 = Customer.new({id: 2, first_name: 'Becky', last_name:  'Benson', created_at:  Time.now, updated_at:  Time.now })
    @customer_3 = Customer.new({id: 3, first_name: 'Pete', last_name:  'Davidson', created_at:  Time.now, updated_at:  Time.now })
    @customer_repo = CustomerRepository.new([customer_1, customer_2, customer_3])
    # @cr = CustomerRepository.new('./data/customer.csv')
  end

  it 'exists' do
    expect(@cr).to be_a(CustomerRepository)
    # expect(@cr.all.[23]).to be_an_instance_of(Customer)
  end

  it 'has attributes' do
    expect(customer_repo).to be_a(CustomerRepository)
    # expect(@cr.all).to be_a(Array)
  end

  # it 'initializes #from_csv' do
  #   expect(@cr).to be_a(CustomerRepository)
  #   expect(@cr.all.length).to eq(999)
  #   expect(@cr.all[23]).to be_a(Customer)
  # end

  it 'finds a specific customer by id' do
    expect(cr.find_by_id )


end
