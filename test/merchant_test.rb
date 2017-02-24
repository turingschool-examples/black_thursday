require './test/test_helper'
require './lib/merchant'
# require './lib/sales_engine'

class MerchantTest < Minitest::Test

  def setup
    @merchant = Merchant.new({
      :merchant_id          => 602397854,
      :merchant_name        => "Burger King",
      :merchant_created_at  => Time.now,
      :merchant_updated_at  => Time.now
      })
  end

  def test_it_has_an_id
    assert_equal 602397854, @merchant.find_id
  end

  def test_it_has_a_name
    assert_equal "Burger King", @merchant.find_name
  end

  def test_it_has_a_created_at
    assert_equal Time, @merchant.when_created_at.class
  end

  def test_it_has_a_updated_at
    assert_equal Time, @merchant.when_updated_at.class
  end
end
