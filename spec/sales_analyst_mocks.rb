require './lib/sales_analyst'

class SalesAnalystMocks
  def self.sales_engine_mock(eg)
    sales_engine_mock = eg.instance_double('SalesEngine')
    eg.allow(sales_engine_mock).to eg.receive(:analyst).and_return SalesAnalyst.new(sales_engine_mock)

    mock_item_repository = eg.instance_double('ItemRepository')
    mock_merchant_repository = eg.instance_double('MerchantRepository')

    eg.allow(sales_engine_mock).to eg.receive(:items).and_return mock_item_repository
    eg.allow(sales_engine_mock).to eg.receive(:merchants).and_return mock_merchant_repository

    sales_engine_mock
  end
end
