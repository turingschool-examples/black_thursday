require './data/customer_mocks'

RSpec.describe CustomerMocks do
  describe '#transions_as_hashes' do
    it 'returns mock data for customers' do
      tas_as_hashes = CustomerMocks.customers_as_hashes

      expect(tas_as_hashes).to be_an Array
      expect(tas_as_hashes.length).to eq 10
      expect(tas_as_hashes.first).to be_a Hash
    end

    it 'generates expected attributes' do
      tas_as_hashes = CustomerMocks.customers_as_hashes

      expect(tas_as_hashes).to be_an Array
      tas_as_hashes.each do |ta_hash|
        expect(ta_hash[:id]).to be_an Integer
        expect(ta_hash[:first_name]).to be_a String
        expect(ta_hash[:last_name]).to be_a String
        expect(ta_hash[:created_at]).to match InvoiceMocks.date_format
        expect(ta_hash[:updated_at]).to match InvoiceMocks.date_format
      end
    end

    it 'returns custom number of mocked hashes' do
      tas_as_hashes = CustomerMocks.customers_as_hashes(number_of_hashes: 3)

      expect(tas_as_hashes.length).to eq 3
    end

    it 'returns custom first_name' do
      tas_as_hashes = CustomerMocks.customers_as_hashes(first_name: 'Bobby Boy')
      tas_as_hashes.each do |ta_hash|
        expect(ta_hash[:first_name]).to eq 'Bobby Boy'
      end
    end

    it 'returns custom last_name' do
      tas_as_hashes = CustomerMocks.customers_as_hashes(last_name: 'Hill')
      tas_as_hashes.each do |ta_hash|
        expect(ta_hash[:last_name]).to eq 'Hill'
      end
    end

    it 'returns non-random time stamps' do
      tas_as_hashes = CustomerMocks.customers_as_hashes(random_dates: false)
      tas_as_hashes.each do |ta_hash|
        expect(ta_hash[:created_at]).to eq '2021-01-01'
      end
    end
  end

  describe '#customers_as_mocks' do
    it 'returns mock data of customers' do
      customers_as_mocks = CustomerMocks.customers_as_mocks(self)

      expect(customers_as_mocks).to be_an Array
      customers_as_mocks.each do |ta_mock|
        expect(ta_mock.id).to be_an Integer
        expect(ta_mock.first_name).to be_a String
        expect(ta_mock.last_name).to be_a String
        expect(ta_mock.created_at).to match InvoiceMocks.date_format
        expect(ta_mock.updated_at).to match InvoiceMocks.date_format
      end
    end
    it 'accepts custom hashes' do
      customer_hashes = CustomerMocks.customers_as_hashes(number_of_hashes: 2)
      customer_mocks = CustomerMocks.customers_as_mocks(self, customer_hashes)
      expect(customer_mocks.length).to eq 2
    end
  end
end
