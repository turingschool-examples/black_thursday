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

  describe '#create' do
    it 'can create a new instance of Customer' do
      highest_id_customer = @cr.repository.sort_by do |customer|
        customer.id.to_i
      end.last
      customer = @cr.create({:first_name => "Sammy", :last_name => "Johannson"})

      expect(customer.id > highest_id_customer.id).to be true
      expect(@cr.repository.include?(customer)).to be true
    end
  end

  describe '#update' do
    it 'can update the first and last name' do
      customer = @cr.find_by_id("1")
      expect(customer.first_name).to eq("Joey")
      expect(customer.last_name).to eq("Ondricka")
      customer_update_time = customer.updated_at

      @cr.update("1", {:first_name => "Joseph", :last_name => "Ondrickann"})
      expect(customer.first_name).to eq("Joseph")
      expect(customer.last_name).to eq("Ondrickann")
      expect(customer.updated_at).not_to eq(customer_update_time)
    end
  end

  describe '#delete' do
    it 'can remove a customer from the repository' do
      customer = @cr.repository.sample
      @cr.delete(customer.id)
      expect(@cr.repository.include?(customer)).to be false
    end
  end
end
