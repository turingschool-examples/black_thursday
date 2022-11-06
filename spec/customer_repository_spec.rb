require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

RSpec.describe CustomerRepository do
  describe '#initilize' do
    it 'exists' do
      cr = CustomerRepository.new

      expect(cr).to be_a CustomerRepository
    end

    it 'can load data' do
      cr = CustomerRepository.new('./data/test_data/customers_test.csv')

      expect(cr.all.all?(Customer)).to be true
      expect(cr.all.length).to eq(10)
    end

    it 'can have an engine' do
      se = SalesEngine.new(customers: './data/test_data/customers_test.csv')
      cr = CustomerRepository.new('./data/test_data/customers_test.csv', se)

      expect(cr.engine).to be_a SalesEngine
    end
  end
  describe '#module methods' do
    describe '#all' do
      it 'returns an array of all customer instances' do
        cr = CustomerRepository.new
        c = Customer.new(
        :id => 6,
        :first_name => "Joan",
        :last_name => "Clarke",
        :created_at => created = Time.now.to_s,
        :updated_at => updated = Time.now.to_s
        ) 

        cr.all << c
      end
    end
  end
end