require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/customer'
require './lib/customer_repo'
require './lib/sales_engine'

RSpec.describe Customer do

  se = SalesEngine.from_csv({
  :customers => "./data/customers.csv",
  })
  customer_repo = se.customers

  context 'it exists' do
    it 'exists' do
      expect(customer_repo.customer_list[0]).to be_instance_of(Customer)
    end
  end

  context 'attr_accessor' do
    it 'can return id' do
      expect(customer_repo.customer_list[0].id).to eq(1)
    end

    it 'can return customer first name' do
      expect(customer_repo.customer_list[0].first_name).to eq("Joey")
    end

    it 'can return customer last name' do
      expect(customer_repo.customer_list[0].last_name).to eq("Ondricka")
    end
  end
end
