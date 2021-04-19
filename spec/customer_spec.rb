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

    it 'can return time created at' do
      expect(customer_repo.customer_list[0].created_at).to eq(Time.parse("2012-03-27 14:54:09 +0000"))
    end
  end
end
