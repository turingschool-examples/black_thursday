require 'CSV'
require './lib/customer_repository'
require './lib/customer'
require 'simplecov'
require 'bigdecimal'

SimpleCov.start

RSpec.describe CustomerRepository do
  before :each do
    # @cr = CustomerRepository.new[Customer.new({id: 24, first_name: 'Esteban', last_name:  'Jenkins', created_at:  Time.now, updated_at:  Time.now })]
    @cr = CustomerRepository.new('./data/customer.csv')
  end

  it 'exists' do
    expect(@cr).to be_a(CustomerRepository)
    # expect(@cr.all.[23]).to be_an_instance_of(Customer)
  end

  it 'has attributes' do
    expect(@cr.all).to be_a(Array)
  end

  # it 'initializes #from_csv' do
  #   expect(@cr).to be_a(CustomerRepository)
  #   expect(@cr.all.length).to eq(999)
  #   expect(@cr.all[23]).to be_a(Customer)
  # end

  it 'populates repository' do
    expect(@cr.all.count).to eq(999)
  end
end
