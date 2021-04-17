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
end
