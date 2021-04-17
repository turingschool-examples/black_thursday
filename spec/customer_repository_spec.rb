require_relative '../lib/sales_engine'
require_relative '../lib/customer_repository'
# require 'bigdecimal/util'

RSpec.describe CustomerRepository do
  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv",
                              :customers => "./data/customers.csv"
                              })
    customer_repo = sales_engine.customers

    it 'exists' do
      expect(customer_repo).to be_instance_of(CustomerRepository)
    end

    it 'can create customer objects' do
      expect(customer_repo.array_of_objects[0]).to be_instance_of(Customer)
    end
  end


end
