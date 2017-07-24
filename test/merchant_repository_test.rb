require './lib/merchant_repository'
require './lib/sales_engine'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })
    @mr = @se.merchant
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_can_return_array_of_known_merchant_instances
    assert_equal 475, @mr.all.count
  end

end
