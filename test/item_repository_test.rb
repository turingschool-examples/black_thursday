require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './lib/sales_engine'
class MerchantRepositoryTest < Minitest::Test
  def setup
    item_path = "./data/items.csv"
    merchant_path = "./data/merchants.csv"
    arguments = {:merchants => merchant_path,
                 :items     => item_path,
                  }
    @se = SalesEngine.new(arguments)
  end
  def test_it_exists

    assert_instance_of MerchantRepository, @se.merchant_repository
    assert_instance_of ItemRepository, @se.item_repository
    assert_equal  475, @se.merchant_repository.merchants.length
    assert_equal 1367, @se.item_repository.items.length
  end

  def test_it_has_attributes
  end
  def test_it_can_have_different_attributes
  end
end
