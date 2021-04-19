require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/sales_engine'
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

  context 'methods' do
    it 'can return all customers' do
      expect(customer_repository.all.class).to eq(Array)
      expect(customer_repository.all.length).to eq(1000)
    end

    it 'can find customer by id' do
      expect(customer_repository.find_by_id(1)).to be_instance_of(Customer)
      expect(customer_repository.find_by_id(1001)).to eq(nil)
      expect(customer_repository.find_by_id(1)).to eq(customer_repository.customer_list[0])
    end

    it 'can find customers by first name' do
      expect(customer_repository.find_all_by_first_name("bi").class).to eq(Array)
      expect(customer_repository.find_all_by_first_name("bi").length).to eq(8)
      expect(customer_repository.find_all_by_first_name("nj")).to eq([])
    end

    it 'can find customers by last name' do
      expect(customer_repository.find_all_by_last_name("ad").class).to eq(Array)
      expect(customer_repository.find_all_by_last_name("ad").length).to eq(18)
      expect(customer_repository.find_all_by_last_name("nj")).to eq([])
    end

    it 'can create new customers' do
      attributes = {
        id: 10001,
        first_name: "Brandon",
        last_name: "Ingram",
        created_at: Time.now,
        updated_at: Time.now
      }
      
      customer_repository.create(attributes)
      expected = customer_repository.find_by_id(1001)
      expect(expected.first_name).to eq("Brandon")
      expect(expected.last_name).to eq("Ingram")
    end
  end
end
