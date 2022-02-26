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

  describe '#find_by_id' do
    it 'can find customers by their id' do
      customer = @cr.find_by_id("23")
      expect(customer.class).to eq(Customer)
      expect(customer.id).to eq("23")
      expect(customer.last_name).to eq("Nader")
    end
  end

  describe '#find by last/first name' do
    it 'can find a customer by name' do
      customer = @cr.find_all_by_first_name("Joey")
      expect(customer.sample.first_name).to eq("Joey")

      customer = @cr.find_all_by_last_name("Smith")
      expect(customer.sample.last_name).to eq("Smith")
      expect(customer.class).to eq(Array)
    end
  end

end
