require 'rspec'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/merchant'
require 'csv'
require './lib/customer'
require './lib/customer_repository'

RSpec.describe CustomerRepository do

  let!(:customer_repository) {CustomerRepository.new("./data/customers.csv", nil)}

  it 'is a customer repository class' do
    require 'pry'; binding.pry
    expect(customer_repository).to be_a(CustomerRepository)
    
  end
  
  
  
  
  
end