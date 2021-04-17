require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/customer_repository'

RSpec.describe Customer do
  describe '#initialize' do
    it 'exists' do
      mock_customer_repo = instance_double('CustomerRepository')
      customer = Customer.new({
                                id: '1',
                                name: 'Joey,Ondricka',
                                created_at: '2012-03-27 14:54:09 UTC',
                                updated_at: '2012-03-27 14:54:09 UTC}'
                              }, mock_customer_repo)

      expect(customer).to be_a(Customer)
    end

    it 'has attributes' do
      mock_customer_repo = instance_double('CustomerRepository')
      customer = Customer.new({
                                id: '1',
                                first_name: 'Joey',
                                last_name: 'Ondricka',
                                created_at: '2012-03-27 14:54:09 UTC',
                                updated_at: '2013-03-27 14:54:09 UTC}'
                              }, mock_customer_repo)

      expect(customer.id).to eq(1)
      expect(customer.first_name).to eq('Joey')
      expect(customer.last_name).to eq('Ondricka')
      expect(customer.created_at.year).to eq(2012)
      expect(customer.updated_at.year).to eq(2013)
    end
  end

  describe '#update_first_name' do
    it 'can update the first name' do
      mock_customer_repo = instance_double('CustomerRepository')
      customer = Customer.new({
                                id: '1',
                                first_name: 'Joey',
                                last_name: 'Ondricka',
                                created_at: '2012-03-27 14:54:09 UTC',
                                updated_at: '2013-03-27 14:54:09 UTC}'
                              }, mock_customer_repo)

      attributes = {first_name: 'Jimmy'}

      customer.update_first_name(attributes)

      expect(customer.first_name).to eq('Jimmy')
    end
  end

  describe '#update_last_name' do
    it 'can update the last name' do
      mock_customer_repo = instance_double('CustomerRepository')
      customer = Customer.new({
                                id: '1',
                                first_name: 'Joey',
                                last_name: 'Ondricka',
                                created_at: '2012-03-27 14:54:09 UTC',
                                updated_at: '2013-03-27 14:54:09 UTC}'
                              }, mock_customer_repo)

      attributes = {last_name: 'Johns'}

      customer.update_last_name(attributes)

      expect(customer.last_name).to eq('Johns')
    end
  end

  describe '#update_time_stamp' do
    it 'can update the updated_at time' do
      mock_customer_repo = instance_double('CustomerRepository')
      customer = Customer.new({
                                id: '1',
                                first_name: 'Joey',
                                last_name: 'Ondricka',
                                created_at: '2012-03-27 14:54:09 UTC',
                                updated_at: '2013-03-27 14:54:09 UTC}'
                              }, mock_customer_repo)

      customer.update_time_stamp

      expect(customer.updated_at.year).to eq(2021)
    end
  end

  describe '#update' do
    it 'updates the customer with the given attributes' do
      mock_customer_repo = instance_double('CustomerRepository')
      customer = Customer.new({
                                id: '1',
                                first_name: 'Joey',
                                last_name: 'Ondricka',
                                created_at: '2012-03-27 14:54:09 UTC',
                                updated_at: '2013-03-27 14:54:09 UTC}'
                              }, mock_customer_repo)

      attributes = {first_name: 'Jimmy', last_name: 'John'}

      customer.update(attributes)
      expect(customer.first_name).to eq('Jimmy')
      expect(customer.last_name).to eq('John')
      expect(customer.created_at.year).to eq(2012)
      expect(customer.updated_at.year).to eq(2021)
    end
  end
end



