require 'rspec'
require './lib/customer_repository'

describe CustomerRepository do
  before (:each) do
    @cr = CustomerRepository.new('./data/customers.csv')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cr).to be_an_instance_of(CustomerRepository)
    end

    it 'creates a repository of Customer instances' do
      customer = @cr.repository.sample
      expect(customer).to be_an_instance_of(Customer)
      expect(@cr.repository.class).to be(Array)
    end
  end

  describe '#all' do
    it 'can return all Customer instances in the repository' do
      expect(@cr.all).to eq(@cr.repository)
    end
  end
end
