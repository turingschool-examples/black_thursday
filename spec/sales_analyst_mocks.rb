require './lib/sales_analyst'
require './lib/item_repository'

class SalesAnalystMocks

  def self.price_sums_for_each_merchant
    @@price_sums_for_each_merchant
  end

  def self.average_prices_for_each_merchant
    @@average_prices_for_each_merchant
  end

  def self.sales_engine_mock(eg)
    sales_engine = eg.instance_double('SalesEngine')
    eg.allow(sales_engine).to eg.receive(:analyst).and_return SalesAnalyst.new(sales_engine)
    sales_engine
  end

  def self.sales_analyst_mock(eg)
    sales_engine = sales_engine_mock(eg)
    sales_analyst = sales_engine.analyst

    merchants_as_hashes = MockData.merchants_as_hashes(number_of_hashes: 4)
    merchants_as_mocks = MockData.merchants_as_mocks(eg, merchants_as_hashes)

    items_as_hashes = MockData.items_as_hashes(number_of_hashes: 3, merchant_id_range: (0..0))
    items_as_hashes += MockData.items_as_hashes(number_of_hashes: 7, merchant_id_range: (1..1))
    items_as_hashes += MockData.items_as_hashes(number_of_hashes: 4, merchant_id_range: (2..2))
    items_as_hashes += MockData.items_as_hashes(number_of_hashes: 12, merchant_id_range: (3..3))

    @@price_sums_for_each_merchant = merchants_as_mocks.each_with_object({}) do |merchant, sums_by_merchant|
      item_hashes = items_as_hashes.find_all do |item_hash|
        item_hash[:merchant_id] == merchant.id
      end
      sum_of_prices = MockData.sum_item_prices_from_hash(item_hashes)
      sums_by_merchant[merchant.id] = sum_of_prices
    end

    @@average_prices_for_each_merchant = merchants_as_mocks.each_with_object({}) do |merchant, avgs_by_merchant|
      item_hashes = items_as_hashes.find_all do |item_hash|
        item_hash[:merchant_id] == merchant.id
      end
      avg_price = MockData.mean_of_item_prices_from_hash(item_hashes)
      avgs_by_merchant[merchant.id] = avg_price
    end

    items_as_mocks = MockData.items_as_mocks(eg, items_as_hashes)

    eg.allow_any_instance_of(ItemRepository).to eg.receive(:create_items).and_return(items_as_mocks)
    eg.allow_any_instance_of(MerchantRepository).to eg.receive(:create_merchants).and_return(merchants_as_mocks)

    item_repository = ItemRepository.new('fake_file')
    merchant_repository = MerchantRepository.new('fake_file')

    eg.allow(sales_engine).to eg.receive(:items).and_return item_repository
    eg.allow(sales_engine).to eg.receive(:merchants).and_return merchant_repository
    sales_analyst
  end
end
