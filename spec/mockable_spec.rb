require './data/item_mocks'
require './data/mockable'

describe Mockable do
  describe '#generator' do
    it 'creates an array with specified length' do
      gen = Mockable.generator(10)

      expect(gen).to be_an Array
      expect(gen.length).to eq 10
    end
  end

  describe '#mock_generator' do
    it 'builds mocks with given hashes' do
      hashes = [{ id: 10, name: 'Example 1' }, { id: 11, name: 'Example 2' }]
      mocks = Mockable.mock_generator(self, 'MockExample', hashes)
      expect(mocks.length).to eq 2
      expect(mocks.first.name).to eq 'Example 1'
    end
  end

  describe '#get_a_random_price' do
    it 'generates a random price' do
      random_price = Mockable.get_a_random_price
      expect(random_price).to be_a Float
    end
  end

  describe '#get_a_random_date' do
    it 'gets a random date with expected format' do
      date = Mockable.get_a_random_date
      expect(date.to_s).to match Mockable.date_format
    end
    it 'gets a non-random date' do
      first_date = Mockable.get_a_random_date false
      second_date = Mockable.get_a_random_date false
      expect(first_date.to_s).to eq second_date.to_s
    end
  end

  describe '#sum_item_prices_from_hash' do
    it 'sums prices' do
      allow(ItemMocks).to receive(:get_a_random_price).and_return(1)
      mock_items = ItemMocks.items_as_hashes
      expected_sum = 10
      actual_sum = Mockable.sum_item_prices_from_hash(mock_items)
      expect(actual_sum).to eq expected_sum
    end
  end

  describe '#mean_of_item_prices_from_hash' do
    it 'gets the mean value of item prices' do
      allow(ItemMocks).to receive(:get_a_random_price).and_return(5)
      allow(Mockable).to receive(:sum_item_prices_from_hash).and_return(50)
      mock_items = ItemMocks.items_as_hashes
      expected_mean = 5
      actual_mean = Mockable.mean_of_item_prices_from_hash(mock_items)
      expect(actual_mean).to eq expected_mean
    end
  end

  describe '#get_a_random_quantity' do
    it 'returns a random status' do
      actual_quantity = Mockable.get_a_random_quantity
      expect(actual_quantity).to be_an Integer
    end
  end
end
