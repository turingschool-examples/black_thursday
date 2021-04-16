require 'rspec'
require './data/mock_data'

describe MockData do
  describe '#mock_generator' do
    it 'builds mocks with given hashes' do
      hashes = [{
        id: 10,
        name: 'Example 1'
      },
      {
        id: 11,
        name: 'Example 2'
      }]
      mocks = MockData.mock_generator(self, 'MockExample', hashes)
      expect(mocks.length).to eq 2
      expect(mocks.first.name).to eq 'Example 1'
    end
  end

  describe '#invoice_items_as_mocks' do
    it 'returns mock data of invoice_items' do
      invoice_items_as_mocks = MockData.invoice_items_as_mocks(self)

      expect(invoice_items_as_mocks).to be_an Array
      invoice_items_as_mocks.each do |invoice_item_mock|
        expect(invoice_item_mock.id).to be_an Integer
        expect(invoice_item_mock.item_id).to be_an Integer
        expect(invoice_item_mock.invoice_id).to be_an Integer
        expect(invoice_item_mock.quantity).to be_an Integer
        expect(invoice_item_mock.unit_price).to be_a Float
        expect(invoice_item_mock.created_at).to match MockData.date_format
        expect(invoice_item_mock.updated_at).to match MockData.date_format
      end
    end
    it 'accepts custom hashes' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes(number_of_hashes: 2)
      invoice_items_as_mocks = MockData.invoice_items_as_mocks(self, invoice_items_as_hashes)
      expect(invoice_items_as_mocks.length).to eq 2
    end
  end

  describe '#invoice_items_as_hashes' do
    it 'returns mock data of invoice items' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes

      expect(invoice_items_as_hashes).to be_an Array
      expect(invoice_items_as_hashes.length).to eq 10
      expect(invoice_items_as_hashes.first).to be_a Hash
    end
    it 'returns data with expected attributes' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes

      invoice_items_as_hashes.each do |invoice_item_hash|
        expect(invoice_item_hash[:id]).to be_an Integer
        expect(invoice_item_hash[:item_id]).to be_an Integer
        expect(invoice_item_hash[:invoice_id]).to be_an Integer
        expect(invoice_item_hash[:quantity]).to be_an Integer
        expect(invoice_item_hash[:unit_price]).to be_a Float
        expect(invoice_item_hash[:created_at]).to match MockData.date_format
        expect(invoice_item_hash[:updated_at]).to match MockData.date_format
      end
    end

    it 'returns custom number of data' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes(number_of_hashes: 2)
      expect(invoice_items_as_hashes.length).to eq 2
    end
    it 'returns non random dates' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes(random_dates: false)
      invoice_items_as_hashes.each do |invoice_item_hash|
        expect(invoice_item_hash[:created_at]).to eq '2021-01-01'
      end
    end
    it 'returns custom ids for item_id' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes(item_id_range: (1..1))
      invoice_items_as_hashes.each do |invoice_item_hash|
        expect(invoice_item_hash[:item_id]).to eq 1
      end
    end
    it 'returns custom ids for invoice_id' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes(invoice_id_range: (1..1))
      invoice_items_as_hashes.each do |invoice_item_hash|
        expect(invoice_item_hash[:invoice_id]).to eq 1
      end
    end
    it 'returns custom quantities' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes(quantity: 3)
      invoice_items_as_hashes.each do |invoice_item_hash|
        expect(invoice_item_hash[:quantity]).to eq 3
      end
    end
    it 'returns custom unit prices' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes(unit_price: 12.54)
      invoice_items_as_hashes.each do |invoice_item_hash|
        expect(invoice_item_hash[:unit_price]).to eq 12.54
      end
    end
  end

  describe '#invoices_as_mocks' do
    it 'returns mock data of invoices' do
      invoices_as_mocks = MockData.invoices_as_mocks(self)

      expect(invoices_as_mocks).to be_an Array
      invoices_as_mocks.each do |invoice_mock|
        expect(invoice_mock.id).to be_an Integer
        expect(invoice_mock.merchant_id).to be_an Integer
        expect(invoice_mock.customer_id).to be_an Integer
        expect(invoice_mock.created_at).to match MockData.date_format
        expect(invoice_mock.updated_at).to match MockData.date_format
      end
    end
    it 'accepts custom hashes' do
      invoices_as_hashes = MockData.invoices_as_hashes(number_of_hashes: 2)
      invoices_as_mocks = MockData.invoices_as_mocks(self, invoices_as_hashes)
      expect(invoices_as_mocks.length).to eq 2
    end
  end

  describe '#invoices_as_hashes' do
    it 'returns mock data of invoices' do
      invoices_as_hashes = MockData.invoices_as_hashes

      expect(invoices_as_hashes).to be_an Array
      expect(invoices_as_hashes.length).to eq 10
      expect(invoices_as_hashes.first).to be_a Hash
    end

    it 'generates expected attributes' do
      invoices_as_hashes = MockData.invoices_as_hashes

      expect(invoices_as_hashes).to be_an Array
      invoices_as_hashes.each do |invoice_hash|
        expect(invoice_hash[:id]).to be_an Integer
        expect(invoice_hash[:customer_id]).to be_an Integer
        expect(invoice_hash[:merchant_id]).to be_an Integer
        expect(invoice_hash[:created_at]).to match MockData.date_format
        expect(invoice_hash[:updated_at]).to match MockData.date_format
      end
    end

    it 'returns mock custom number of data of invoices' do
      invoices_as_hashes = MockData.invoices_as_hashes(number_of_hashes: 2)
      expect(invoices_as_hashes.length).to eq 2
    end

    it 'returns mocks with custom status' do
      invoices_as_hashes = MockData.invoices_as_hashes(status: 'pending')

      invoices_as_hashes.each do |invoice_hash|
        expect(invoice_hash[:status]).to eq 'pending'
      end
    end

    it 'returns mocks with non-random ids' do
      invoices_as_hashes = MockData.invoices_as_hashes(customer_id_range: (1..1),
                                                       merchant_id_range: (5..5))

      invoices_as_hashes.each do |invoice_hash|
        expect(invoice_hash[:customer_id]).to eq 1
        expect(invoice_hash[:merchant_id]).to eq 5
      end
    end

    it 'returns non-random dates' do
      invoices_as_hashes = MockData.invoices_as_hashes(random_dates: false)
      invoices_as_hashes.each do |invoice_hash|
        expect(invoice_hash[:created_at]).to eq '2021-01-01'
      end
    end
  end

  describe '#merchants_as_mocks' do
    it 'returns mocks of merchants' do
      merchants_as_mocks = MockData.merchants_as_mocks(self)

      expect(merchants_as_mocks).to be_instance_of Array
      merchants_as_mocks.each do |merchant_mock|
        expect(merchant_mock.name).to be_a String
        expect(merchant_mock.id).to be_an Integer
        expect(merchant_mock.created_at).to match MockData.date_format
        expect(merchant_mock.updated_at).to match MockData.date_format
      end
    end
    it 'accepts custom hashes' do
      merchants_as_hashes = MockData.merchants_as_hashes(number_of_hashes: 2)
      merchants_as_mocks = MockData.merchants_as_mocks(self, merchants_as_hashes)
      expect(merchants_as_mocks.length).to eq 2
    end
  end

  describe '#mechants_as_hashes' do
    it 'returns mock data as an array of hashes' do
      merchants_as_hashes = MockData.merchants_as_hashes

      expect(merchants_as_hashes).to be_an Array
      expect(merchants_as_hashes.length).to eq 10
      expect(merchants_as_hashes.first).to be_a Hash
    end

    it 'returns expected attributes' do
      mocked_hash_data = MockData.merchants_as_hashes

      mocked_hash_data.each do |merchant_hash|
        expect(merchant_hash[:name]).to be_a String
        expect(merchant_hash[:id]).to be_an Integer
        expect(merchant_hash[:created_at]).to match MockData.date_format
        expect(merchant_hash[:updated_at]).to match MockData.date_format
      end
    end

    it 'returns non random dates' do
      merchants_as_hashes = MockData.merchants_as_hashes(random_dates: false)
      merchants_as_hashes.each do |merchant_hash|
        expect(merchant_hash[:created_at]).to eq '2021-01-01'
      end
    end

    it 'returns custom number of hashes' do
      merchants_as_hashes = MockData.merchants_as_hashes(number_of_hashes: 20)
      expect(merchants_as_hashes.length).to eq 20
    end
  end

  describe '#items_as_mocks' do
    it 'returns mocks items with expected attributes' do
      items_as_mocks = MockData.items_as_mocks(self)
      expect(items_as_mocks).to be_instance_of Array

      items_as_mocks.each do |item_mock|
        expect(item_mock.name).to be_a String
        expect(item_mock.id).to be_an Integer
        expect(item_mock.merchant_id).to be_an Integer
        expect(item_mock.unit_price).to be_a Float
        expect(item_mock.description).to be_a String
        expect(item_mock.created_at).to match MockData.date_format
        expect(item_mock.updated_at).to match MockData.date_format
      end
    end

    it 'accepts custom hashes' do
      items_as_hashes = MockData.items_as_hashes(number_of_hashes: 2)
      items_as_mocks = MockData.items_as_mocks(self, items_as_hashes)
      expect(items_as_mocks.length).to eq 2
    end
  end

  describe '#items_as_hashes' do
    it 'returns mock data as an array of hashes' do
      items_as_hashes = MockData.items_as_hashes

      expect(items_as_hashes).to be_an Array
      expect(items_as_hashes.length).to eq 10
      expect(items_as_hashes.first).to be_a Hash
    end
    it 'returns mock data of items with expected attributes' do
      items_as_hashes = MockData.items_as_hashes

      items_as_hashes.each do |item_hash|
        expect(item_hash[:name]).to be_a String
        expect(item_hash[:id]).to be_an Integer
        expect(item_hash[:merchant_id]).to be_an Integer
        expect(item_hash[:unit_price]).to be_a Float
        expect(item_hash[:description]).to be_a String
        expect(item_hash[:created_at]).to match MockData.date_format
        expect(item_hash[:updated_at]).to match MockData.date_format
      end
    end

    it 'returns custom number of hashes' do
      items_as_hashes = MockData.items_as_hashes(number_of_hashes: 20)
      expect(items_as_hashes.length).to eq 20
    end

    it 'allows non-random dates' do
      items_as_hashes = MockData.items_as_hashes(random_dates: false)
      items_as_hashes.each do |item_hash|
        expect(item_hash[:created_at]).to eq '2021-01-01'
      end
    end

    it 'allows for custom unit prices' do
      items_as_hashes = MockData.items_as_hashes(unit_price: 4.50)
      items_as_hashes.each do |item_hash|
        expect(item_hash[:unit_price]).to eq 4.50
      end
    end

    it 'allows for custom merchant distribution' do
      items_as_hashes = MockData.items_as_hashes(number_of_merchants: 5,
                                                 number_of_hashes: 25)

      number_of_merchants = items_as_hashes.count do |item_hash|
        item_hash[:merchant_id] == 0
      end

      expect(number_of_merchants).to eq 5
    end
  end

  describe '#get_a_random_price' do
    it 'generates a random price' do
      random_price = MockData.get_a_random_price
      expect(random_price).to be_a Float
    end
  end

  describe '#get_a_random_date' do
    it 'gets a random date with expected format' do
      date = MockData.get_a_random_date
      expect(date.to_s).to match MockData.date_format
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
      mock_items = MockData.items_as_hashes
      expected_sum = 10
      actual_sum = MockData.sum_item_prices_from_hash(mock_items)
      expect(actual_sum).to eq expected_sum
    end
  end

  describe '#mean_of_item_prices_from_hash' do
    it 'gets the mean value of item prices' do
      allow(MockData).to receive(:get_a_random_price).and_return(5)
      allow(MockData).to receive(:sum_item_prices_from_hash).and_return(50)
      mock_items = MockData.items_as_hashes
      expected_mean = 5
      actual_mean = MockData.mean_of_item_prices_from_hash(mock_items)
      expect(actual_mean).to eq expected_mean
    end
  end

  describe '#get_a_random_status' do
    it 'returns a random status' do
      actual_status = MockData.get_a_random_status
      possible_statuses = ['pending', 'shipped', 'returned']
      expect(possible_statuses.include?(actual_status)).to be true
    end
  end

  describe '#get_a_random_quantity' do
    it 'returns a random status' do
      actual_quantity = MockData.get_a_random_quantity
      expect(actual_quantity).to be_an Integer
    end
  end
end
