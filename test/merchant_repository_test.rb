require './lib/merchant_repository'
require './lib/sales_engine'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'
require 'bigdecimal'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
          :items     => "./test/data/items_fixture.csv",
          :merchants => "./test/data/merchants_fixture.csv",
          })
    @mr = @se.merchant
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_can_return_array_of_known_merchant_instances
    assert_equal 50, @mr.all.count
  end

  def test_find_by_id_return_id_or_nil
    assert_instance_of Merchant, @mr.find_by_id(12334132)
    assert_nil @mr.find_by_id("12478678")
  end

  def test_find_by_name
    assert_instance_of Merchant, @mr.find_by_name("GoldenRayPress")
    assert_nil @mr.find_by_id("akshfkh")
  end

  def test_find_all_by_name
    assert_equal 4, @mr.find_all_by_name("Shop").count
    assert_equal [], @mr.find_all_by_name("skjdfhjg")
  end

end
