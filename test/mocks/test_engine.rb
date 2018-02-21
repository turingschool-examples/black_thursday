# frozen_string_literal: true

require_relative '../../lib/sales_engine'
require_relative '../../lib/item_repository'
require_relative '../../lib/merchant_repository'

MOCK_MERCHANT_REPOSITORY = MerchantRepository.new(
  './test/fixtures/merchants.csv'
)
MOCK_ITEM_REPOSITORY = ItemRepository.new './test/fixtures/items.csv'

MOCK_SALES_ENGINE = SalesEngine.new(
  MOCK_ITEM_REPOSITORY,
  MOCK_MERCHANT_REPOSITORY
)
