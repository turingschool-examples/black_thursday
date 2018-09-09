# TO DO - Add these to simplecov
require 'minitest/autorun'
require 'minitest/pride'

require 'pry'

# TO DO  - change these to require require_relative
require './lib/item'
# require './lib/item_repository'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/sales_engine'


class SalesEngineTest < Minitest::Test

  def setup
    @hash = { :items     => "./data/items.csv",
              :merchants => "./data/merchants.csv",
            }
    @se_new = SalesEngine.new
    # binding.pry # BUG below
    @se_csv = SalesEngine.from_csv(@hash)
    # binding.pry
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se_new
  end

  def test_it_can_be_created_via_from_csv_method
    # BUG
    assert_instance_of SalesEngine, @se_csv #.itself
    # assert_instance_of MerchantRepository, @se_csv.merchants  # ERROR, is Array



  end

  def test_it_gets_attrubutes
    # -- via .new --
    assert_nil @se_new.items
    assert_nil @se_new.merchants
    # -- via .from_csv --
    # assert_instance_of ItemRepository, @se_csv.items
    # assert_instance_of Item, @se_csv.items[0]
    # assert_instance_of MerchantRepository, @se_csv.merchants  # ERROR, is Array
    # assert_instance_of Merchant, @se_csv.merchants[0]
  end

end
