require_relative '../lib/customer_repository'
require_relative '../lib/customer'
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

    it 'has a child' do
      cr = CustomerRepository.new

      expect(cr.child).to eq(Customer)
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
        cr = CustomerRepository.new('./data/test_data/customers_test.csv')

        expect(cr.all.length).to eq(10)
        expect(cr.all.all?(Customer)).to be true
      end
    end

    describe '#find_by_id' do
      it 'returns nil or instance of customer by id' do
        cr = CustomerRepository.new('./data/test_data/customers_test.csv')

        expect(cr.find_by_id(11)).to eq(nil)
        expect(cr.find_by_id(10)).to eq(cr.all[-1])
      end
    end

    describe '#create' do
      it 'creates a new customer instance with the id one higher than the current highest' do
        cr = CustomerRepository.new('./data/test_data/customers_test.csv')

        cr.create(
          :id => 6,
          :first_name => "Joan",
          :last_name => "Clarke",
          :created_at => Time.now.to_s,
          :updated_at => Time.now.to_s
        )

        expect(cr.all[-1]).to be_a Customer
        expect(cr.all[-1].first_name).to eq("Joan")
        expect(cr.all[-1].last_name).to eq("Clarke")
        expect(cr.all[-1].id).to eq(11)
      end
    end
  end
end