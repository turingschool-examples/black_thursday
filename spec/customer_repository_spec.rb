require 'csv'
require 'pry'
require 'customer'
require 'customer_repository'
RSpec.describe CustomerRepository do
  before :each do
    @customer_repository = CustomerRepository.new("./data/customers.csv")
  end
  it 'exists' do
    expect(@customer_repository).to be_a CustomerRepository
  end
end
