require 'rspec'
require 'CSV'
require './lib/sales_engine'
require './lib/sales_analyst'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/file_io'

describe SalesEngine do
  describe '#from_csv' do
    it 'creates a new instance of SalesEngine' do
      item_details = MockData.items_as_hash
      mock_items = MockData.items_as_mocks(item_details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      merchant_details = MockData.merchants_as_hash
      mock_merchants = MockData.merchants_as_mocks(merchant_details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      files = { items: './file1.csv', merchants: './file2.csv' }
      sales_engine = SalesEngine.from_csv(files)

      expect(sales_engine).to be_instance_of SalesEngine
    end
  end

  describe '#items' do
    it 'has an ItemRepository' do
      item_details = MockData.items_as_hash
      mock_items = MockData.items_as_mocks(item_details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      merchant_details = MockData.merchants_as_hash
      mock_merchants = MockData.merchants_as_mocks(merchant_details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      files = { items: './file1.csv', merchants: './file2.csv' }
      sales_engine = SalesEngine.from_csv(files)

      expect(sales_engine.items).is_a? ItemRepository
    end

    it 'has Items in the ItemRepository' do
      item_details = MockData.items_as_hash
      mock_items = MockData.items_as_mocks(item_details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      merchant_details = MockData.merchants_as_hash
      mock_merchants = MockData.merchants_as_mocks(merchant_details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      files = { items: './file1.csv', merchants: './file2.csv' }
      sales_engine = SalesEngine.from_csv(files)

      item_repo = sales_engine.items
      expect(item_repo.items.first).is_a? Item
    end
  end

  describe '#merchants' do
    it 'has an MerchantRepository' do
      item_details = MockData.items_as_hash
      mock_items = MockData.items_as_mocks(item_details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      merchant_details = MockData.merchants_as_hash
      mock_merchants = MockData.merchants_as_mocks(merchant_details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      files = { items: './file1.csv', merchants: './file2.csv' }
      sales_engine = SalesEngine.from_csv(files)

      expect(sales_engine.merchants).is_a? MerchantRepository
    end

    # it 'has Merchants in the MerchantRepository' do
    #   item_details = MockData.items_as_hash
    #   mock_items = MockData.items_as_mocks(item_details) { self }
    #   allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
    #   merchant_details = MockData.merchants_as_hash
    #   mock_merchants = MockData.merchants_as_mocks(merchant_details) { self }
    #   allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
    #   files = { items: './file1.csv', merchants: './file2.csv' }
    #   sales_engine = SalesEngine.from_csv(files)
    #
    #   merchant_repo = sales_engine.merchants
    #   expect(merchant_repo.merchants.first).is_a? Merchant
    # end
  end


  describe '#analyst' do
    it 'returns a new instance of SalesAnalyst' do
      item_details = MockData.items_as_hash
      mock_items = MockData.items_as_mocks(item_details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      merchant_details = MockData.merchants_as_hash
      mock_merchants = MockData.merchants_as_mocks(merchant_details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      files = { items: './file1.csv', merchants: './file2.csv' }
      sales_engine = SalesEngine.from_csv(files)

      sales_analyst = sales_engine.analyst
      expect(sales_analyst).to be_instance_of SalesAnalyst
    end
  end
end
