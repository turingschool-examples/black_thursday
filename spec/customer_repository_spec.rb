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

  describe 'parent class methods' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv",
                              :customers => "./data/customers.csv"
                              })
    customer_repo = sales_engine.customers

    describe '#all' do
      it 'returns array of all customers' do
        expect(customer_repo.all.length).to eq(1000)
      end
    end

    it '#find_by_id returns an instance by matching id' do
      id = 50

      expect(customer_repo.find_by_id(id).id).to eq(id)
      expect(customer_repo.find_by_id(id).first_name).to eq("Brent")
    end

    describe '#delete' do
      it 'can delete customer' do
        customer_repo.delete(50)
        expected = customer_repo.find_by_id(50)
        expect(expected).to eq(nil)
      end
    end
  end


end
