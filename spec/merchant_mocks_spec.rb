require './data/merchant_mocks'

RSpec.describe MerchantMocks do
  describe '#merchants_as_mocks' do
    it 'returns mocks of merchants' do
      merchants_as_mocks = MerchantMocks.merchants_as_mocks(self)

      expect(merchants_as_mocks).to be_instance_of Array
      merchants_as_mocks.each do |merchant_mock|
        expect(merchant_mock.name).to be_a String
        expect(merchant_mock.id).to be_an Integer
        expect(merchant_mock.created_at).to match MerchantMocks.date_format
        expect(merchant_mock.updated_at).to match MerchantMocks.date_format
      end
    end

    it 'accepts custom hashes' do
      merchants_as_hashes = MerchantMocks.merchants_as_hashes(number_of_hashes: 2)
      merchants_as_mocks = MerchantMocks.merchants_as_mocks(self, merchants_as_hashes)
      expect(merchants_as_mocks.length).to eq 2
    end
  end

  describe '#mechants_as_hashes' do
    it 'returns mock data as an array of hashes' do
      merchants_as_hashes = MerchantMocks.merchants_as_hashes

      expect(merchants_as_hashes).to be_an Array
      expect(merchants_as_hashes.length).to eq 10
      expect(merchants_as_hashes.first).to be_a Hash
    end

    it 'returns expected attributes' do
      mocked_hash_data = MerchantMocks.merchants_as_hashes

      mocked_hash_data.each do |merchant_hash|
        expect(merchant_hash[:name]).to be_a String
        expect(merchant_hash[:id]).to be_an Integer
        expect(merchant_hash[:created_at]).to match MerchantMocks.date_format
        expect(merchant_hash[:updated_at]).to match MerchantMocks.date_format
      end
    end

    it 'returns non random dates' do
      merchants_as_hashes = MerchantMocks.merchants_as_hashes(random_dates: false)
      merchants_as_hashes.each do |merchant_hash|
        expect(merchant_hash[:created_at]).to eq '2021-01-01'
      end
    end

    it 'returns custom number of hashes' do
      merchants_as_hashes = MerchantMocks.merchants_as_hashes(number_of_hashes: 20)
      expect(merchants_as_hashes.length).to eq 20
    end
  end
end
