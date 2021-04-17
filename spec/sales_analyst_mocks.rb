require './lib/sales_analyst'

class SalesAnalystMocks

  def self.sum_of_prices_merchant3
    @@sum_of_prices_merchant3
  end

  def self.sales_engine_mock(eg)
    sales_engine = eg.instance_double('SalesEngine')
    eg.allow(sales_engine).to eg.receive(:analyst).and_return SalesAnalyst.new(sales_engine)

    mock_item_repository = eg.instance_double('ItemRepository')
    mock_merchant_repository = eg.instance_double('MerchantRepository')

    eg.allow(sales_engine).to eg.receive(:items).and_return mock_item_repository
    eg.allow(sales_engine).to eg.receive(:merchants).and_return mock_merchant_repository

    sales_engine
  end

  def self.sales_analyst_mock(eg)
    sales_engine = sales_engine_mock(eg)
    sales_analyst = sales_engine.analyst

    items_as_hashes = MockData.items_as_hashes(number_of_hashes: 3, merchant_id_range: (0..0))
    items_as_hashes += MockData.items_as_hashes(number_of_hashes: 7, merchant_id_range: (1..1))
    items_as_hashes += MockData.items_as_hashes(number_of_hashes: 4, merchant_id_range: (2..2))
    items_as_hashes_merchant3 = MockData.items_as_hashes(number_of_hashes: 12, merchant_id_range: (3..3))
    items_as_hashes += items_as_hashes_merchant3

    @@sum_of_prices_merchant3 = MockData.sum_item_prices_from_hash(items_as_hashes_merchant3)

    items_as_mocks = MockData.items_as_mocks(eg, items_as_hashes)
    merchants_as_hashes = MockData.merchants_as_hashes(number_of_hashes: 4)
    merchants_as_mocks = MockData.merchants_as_mocks(eg, merchants_as_hashes)

    eg.allow(sales_engine.items).to eg.receive(:all).and_return items_as_mocks
    eg.allow(sales_engine.merchants).to eg.receive(:all).and_return merchants_as_mocks

    sales_analyst
  end
end
