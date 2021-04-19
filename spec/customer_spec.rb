require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/customer'
require './lib/customer_repo'
require './lib/sales_engine'

RSpec.describe Customer do

  se = SalesEngine.from_csv({
  :customers => "./data/invoices.csv",
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
  end
end
