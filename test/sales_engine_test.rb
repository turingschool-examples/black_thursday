# frozen_string_literal: true

require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require './test/test_helper'
require_relative '../lib/sales_engine'
class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(items: './data/items.csv',
                               merchants: './data/merchants.csv')
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_contains_repositories
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of SalesAnalyst, @se.analyst
  end
end
