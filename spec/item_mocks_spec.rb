require 'rspec'
require './data/item_mocks'

RSpec.describe ItemMocks do
  describe '#items_as_mocks' do
    it 'returns mocks items with expected attributes' do
      items_as_mocks = ItemMocks.items_as_mocks(self)
      expect(items_as_mocks).to be_instance_of Array

      items_as_mocks.each do |item_mock|
        expect(item_mock.name).to be_a String
        expect(item_mock.id).to be_an Integer
        expect(item_mock.merchant_id).to be_an Integer
        expect(item_mock.unit_price).to be_a Float
        expect(item_mock.description).to be_a String
        expect(item_mock.created_at).to match ItemMocks.date_format
        expect(item_mock.updated_at).to match ItemMocks.date_format
      end
    end

    it 'accepts custom hashes' do
      items_as_hashes = ItemMocks.items_as_hashes(number_of_hashes: 2)
      items_as_mocks = ItemMocks.items_as_mocks(self, items_as_hashes)
      expect(items_as_mocks.length).to eq 2
    end
  end

  describe '#items_as_hashes' do
    it 'returns mock data as an array of hashes' do
      items_as_hashes = ItemMocks.items_as_hashes

      expect(items_as_hashes).to be_an Array
      expect(items_as_hashes.length).to eq 10
      expect(items_as_hashes.first).to be_a Hash
    end
    it 'returns mock data of items with expected attributes' do
      items_as_hashes = ItemMocks.items_as_hashes

      items_as_hashes.each do |item_hash|
        expect(item_hash[:name]).to be_a String
        expect(item_hash[:id]).to be_an Integer
        expect(item_hash[:merchant_id]).to be_an Integer
        expect(item_hash[:unit_price]).to be_a Float
        expect(item_hash[:description]).to be_a String
        expect(item_hash[:created_at]).to match ItemMocks.date_format
        expect(item_hash[:updated_at]).to match ItemMocks.date_format
      end
    end

    it 'returns custom number of hashes' do
      items_as_hashes = ItemMocks.items_as_hashes(number_of_hashes: 20)
      expect(items_as_hashes.length).to eq 20
    end

    it 'allows non-random dates' do
      items_as_hashes = ItemMocks.items_as_hashes(random_dates: false)
      items_as_hashes.each do |item_hash|
        expect(item_hash[:created_at]).to eq '2021-01-01'
      end
    end

    it 'allows for custom unit prices' do
      items_as_hashes = ItemMocks.items_as_hashes(unit_price: 4.50)
      items_as_hashes.each do |item_hash|
        expect(item_hash[:unit_price]).to eq 4.50
      end
    end

    it 'allows for custom merchant distribution' do
      items_as_hashes = ItemMocks.items_as_hashes(merchant_id: 2,
                                                  number_of_hashes: 25)

      items_as_hashes.each do |item_hash|
        expect(item_hash[:merchant_id]).to eq 2
      end
    end
  end
end
