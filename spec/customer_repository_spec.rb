require './lib/customer'
require './lib/customer_repository'

RSpec.describe do
  it 'exists' do
    customer_path = './data/customers.csv'
    customer_repository = CustomerRepository.new(customer_path)

    expect(customer_repository).to be_an_instance_of(CustomerRepository)
  end

  it 'can return an array of all known customers' do
    customer_path = './data/customers.csv'
    customer_repository = CustomerRepository.new(customer_path)
    expect(customer_repository.all[0]).to be_an_instance_of(Customer)
    expect(customer_repository.all.count).to eq 1000
  end

  it 'can find customer by id' do
    customer_path = './data/customers.csv'
    customer_repository = CustomerRepository.new(customer_path)
    example_customer = customer_repository.all[25]
    expect(customer_repository.find_by_id(example_customer.id)).to eq(example_customer)
    expect(customer_repository.find_by_id(999999)).to eq nil
  end
end
