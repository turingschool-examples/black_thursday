# frozen_string_literal: true

require_relative '../../lib/sales_engine'
require_relative '../../lib/item_repository'
require_relative '../../lib/merchant_repository'

MOCK_SALES_ENGINE = SalesEngine.from_csv(
  invoices: './test/fixtures/invoices.csv',
  items: './test/fixtures/items.csv',
  merchants: './test/fixtures/merchants.csv'
)

MOCK_ITEM_REPOSITORY = MOCK_SALES_ENGINE.items
MOCK_MERCHANT_REPOSITORY = MOCK_SALES_ENGINE.merchants
MOCK_INVOICE_REPOSITORY = MOCK_SALES_ENGINE.invoices
