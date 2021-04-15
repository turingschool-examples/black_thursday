require 'rspec'
require './data/mock_data'

describe MockData do

  describe '#invoices_as_hash' do
    it 'returns mock data of invoices' do
      invoices_as_hash = MockData.invoices_as_hash

      expect(invoices_as_hash).to be_instance_of Array
      expect(invoices_as_hash.length).to eq 10
      expect(invoices_as_hash.first).to be_instance_of Hash
    end

    it 'returns mock custom number of data of invoices' do
      invoices_as_hash = MockData.invoices_as_hash(number_of_mocks: 2)
      expect(invoices_as_hash.length).to eq 2
    end

    it 'returns mocks with custom status' do
      invoices_as_hash = MockData.invoices_as_hash(custom_status: 'pending')

      invoices_as_hash.each do |invoice_hash|
        expect(invoice_hash[:status]).to eq 'pending'
      end
    end

    it 'returns mocks with non-random ids' do
      invoices_as_hash = MockData.invoices_as_hash(customer_id_range: (1..1),
                                                   merchant_id_range: (5..5))

      invoices_as_hash.each do |invoice_hash|
        expect(invoice_hash[:customer_id]).to eq 1
        expect(invoice_hash[:merchant_id]).to eq 5
      end
    end
  end

  describe '#get_a_random_status' do
    it 'returns a random status' do
      actual_status = MockData.get_a_random_status
      possible_statuses = ['pending', 'shipped', 'returned']
      expect(possible_statuses.include?(actual_status)).to be true
    end
  end

  describe '#merchants_as_mocks' do
    it 'returns mock data as an array of mocks' do
      merchant_hashs = MockData.merchants_as_hash
      merchants_as_mocks = MockData.merchants_as_mocks(merchant_hashs) { self }

      expect(merchants_as_mocks).to be_instance_of Array
      expect(merchants_as_mocks.length).to eq 10
    end

    it 'returns mock data of merchants' do
      merchant_hashs = MockData.merchants_as_hash(number_of_mocks: 2)
      merchants_as_mocks = MockData.merchants_as_mocks(merchant_hashs) { self }
      mocked_merchant = merchants_as_mocks.first
      expect(merchants_as_mocks.length).to eq 2
      expect(mocked_merchant.name).to eq 'Merchant 0'
      expect(mocked_merchant.id).to eq 0
      expect(mocked_merchant.created_at).to match(/\d{4}-\d{2}-\d{2}/)
      expect(mocked_merchant.updated_at).to match(/\d{4}-\d{2}-\d{2}/)
    end
  end

  describe '#mechants_as_hash' do
    it 'returns mock data as an array of hashes' do
      merchants_as_hash = MockData.merchants_as_hash

      expect(merchants_as_hash).to be_instance_of Array
      expect(merchants_as_hash.length).to eq 10
      expect(merchants_as_hash.first).to be_instance_of Hash
    end

    it 'returns mock data of merchants' do
      mocked_hash_data = MockData.merchants_as_hash(number_of_mocks: 2)
      mocked_merchant = mocked_hash_data.first
      expect(mocked_hash_data.length).to eq 2
      expect(mocked_merchant[:name]).to eq 'Merchant 0'
      expect(mocked_merchant[:id]).to eq 0
      expect(mocked_merchant[:created_at]).to match(/\d{4}-\d{2}-\d{2}/)
      expect(mocked_merchant[:updated_at]).to match(/\d{4}-\d{2}-\d{2}/)
    end
  end

  describe '#items_as_mocks' do
    it 'returns mock items as an array of mocks' do
      items_as_hash = MockData.items_as_hash
      items_as_mocks = MockData.items_as_mocks(items_as_hash) { self }

      expect(items_as_mocks).to be_instance_of Array
      expect(items_as_mocks.length).to eq 10
    end

    it 'returns mock data of items with expected attributes' do
      items_as_hash = MockData.items_as_hash(number_of_mocks: 2)
      mocks = MockData.items_as_mocks(items_as_hash) { self }
      mocked_item = mocks.first
      expect(mocks.length).to eq 2
      expect(mocked_item.name).to eq 'Item 0'
      expect(mocked_item.id).to eq 0
      expect(mocked_item.merchant_id).to be_instance_of Integer
      expect(mocked_item.unit_price).to be_instance_of Float
      expect(mocked_item.description).to eq 'Item Description'
      expect(mocked_item.created_at).to match(/\d{4}-\d{2}-\d{2}/)
      expect(mocked_item.updated_at).to match(/\d{4}-\d{2}-\d{2}/)
    end
  end

  describe '#items_as_hash' do
    it 'returns mock data as an array of hashes' do
      items_as_hash = MockData.items_as_hash

      expect(items_as_hash).to be_instance_of Array
      expect(items_as_hash.length).to eq 10
      expect(items_as_hash.first).to be_instance_of Hash
    end

    it 'returns mock data of items with expected attributes' do
      items_as_hash = MockData.items_as_hash(number_of_mocks: 2)
      first_item_hash = items_as_hash.first
      expect(items_as_hash.length).to eq 2
      expect(first_item_hash[:name]).to eq 'Item 0'
      expect(first_item_hash[:id]).to eq 0
      expect(first_item_hash[:merchant_id]).to be_instance_of Integer
      expect(first_item_hash[:unit_price]).to be_instance_of Float
      expect(first_item_hash[:description]).to eq 'Item Description'
      expect(first_item_hash[:created_at]).to match(/\d{4}-\d{2}-\d{2}/)
      expect(first_item_hash[:updated_at]).to match(/\d{4}-\d{2}-\d{2}/)
    end
    it 'returns mock data of items with given number_of_merchants' do
      items_as_hash = MockData.items_as_hash(number_of_mocks: 2, number_of_merchants: 1)

      expect(items_as_hash.first[:merchant_id]).to eq 0
      expect(items_as_hash.last[:merchant_id]).to eq 0
    end
  end

  describe '#get_a_random_price' do
    it 'generates a random price' do
      random_price = MockData.get_a_random_price
      expect(random_price).to be_instance_of Float
    end
  end

  describe '#get_a_random_date' do
    it 'gets a random date with expected format' do
      date = MockData.get_a_random_date
      expect(date.to_s).to match(/\d{4}-\d{2}-\d{2}/)
    end
    it 'gets a non-random date' do
      first_date = MockData.get_a_random_date false
      second_date = MockData.get_a_random_date false
      expect(first_date.to_s).to eq second_date.to_s
    end
  end

  describe '#sum_item_prices_from_hash' do
    it 'sums prices' do
      allow(MockData).to receive(:get_a_random_price).and_return(1)
      mock_items = MockData.items_as_hash
      expected_sum = 10
      actual_sum = MockData.sum_item_prices_from_hash(mock_items)
      expect(actual_sum).to eq expected_sum
    end
  end

  describe '#mean_of_item_prices_from_hash' do
    it 'gets the mean value of item prices' do
      allow(MockData).to receive(:get_a_random_price).and_return(5)
      allow(MockData).to receive(:sum_item_prices_from_hash).and_return(50)
      mock_items = MockData.items_as_hash
      expected_mean = 5
      actual_mean = MockData.mean_of_item_prices_from_hash(mock_items)
      expect(actual_mean).to eq expected_mean
    end
  end
end
