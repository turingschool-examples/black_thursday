require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/sales_engine'
require './lib/items'
require './lib/items_repo'
require './lib/merchants'
require './lib/merchants_repo'
require './lib/invoices'
require './lib/invoices_repo'
require './lib/customer'
require './lib/customer_repo'

RSpec.describe Customer do

  se = SalesEngine.from_csv({
  :customers => "./data/customers.csv",
  })
  customer_repository = se.customers

  context 'it exists' do
    it 'exists' do
      expect(customer_repository).to be_instance_of(CustomerRepo)
    end
  end
end
