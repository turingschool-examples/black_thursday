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

  it "can find a customer by id and return nil if no customer is found" do
    expect(@customer_repository.find_by_id(0)).to eq nil
    expect(@customer_repository.find_by_id(1)).to be_a(Customer)
    expect(@customer_repository.find_by_id(1000)).to be_a(Customer)
  end

end
