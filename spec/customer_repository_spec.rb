require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

RSpec.describe CustomerRepository do
  describe '#initialize' do
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
          :first_name => 'Joan',
          :last_name => 'Clarke',
          :created_at => Time.now.to_s,
          :updated_at => Time.now.to_s
        )

        expect(cr.all[-1]).to be_a Customer
        expect(cr.all[-1].first_name).to eq('Joan')
        expect(cr.all[-1].last_name).to eq('Clarke')
        expect(cr.all[-1].id).to eq(11)
      end
    end

    describe '#delete' do
      it 'can delete and instance of customer' do
        cr = CustomerRepository.new('./data/test_data/customers_test.csv')

        expect(cr.all.length).to eq(10)
        expect(cr.all[0].id).to eq(1)
        expect(cr.all[0].first_name).to eq('Joey')
        
        cr.delete(1)

        expect(cr.all.length).to eq(9)
        expect(cr.all[0].id).to eq(2)
        expect(cr.all[0].first_name).to eq("Cecelia")
      end
    end
  end

  describe '#update' do
    it 'only update a customers first and last name and updates the time to current time' do
      cr = CustomerRepository.new('./data/test_data/customers_test.csv')

      expect(cr.all[0].id).to eq(1)
      expect(cr.all[0].first_name).to eq('Joey')
      expect(cr.all[0].last_name).to eq('Ondricka')
      expect(cr.all[0].updated_at).to eq(Time.parse('2012-03-27 14:54:09 UTC'))

      cr.update(1, {:first_name => 'John', :last_name => 'Smith'})

      expect(cr.all[0].id).to eq(1)
      expect(cr.all[0].first_name).to eq('John')
      expect(cr.all[0].last_name).to eq('Smith')
      expect(cr.all[0].updated_at).to be > Time.parse('2012-03-27 14:54:09 UTC')
    end
  end

  describe '#find_all_by_first_name' do
    it 'returns an empty array or one or more customers matching the substring fragment' do
      cr = CustomerRepository.new('./data/test_data/customers_test.csv')

      fragment = 'ia'

      expected = cr.find_all_by_first_name(fragment)

      expect(expected.length).to eq(2)
      expect(expected.first.class).to eq(Customer)
    end
  end
end