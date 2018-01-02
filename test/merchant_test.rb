require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_merchant_exists
    merchant = Merchant.new("1", "Cornelius", "13:02", "13:03")

    assert_instance_of Merchant, merchant
  end

  def test_id_is_accurate
    merchant = Merchant.new("1", "Cornelius", "13:02", "13:03")

    assert_equal "1", merchant.id
  end

  def test_name_is_accurate
    merchant = Merchant.new("1", "Cornelius", "13:02", "13:03")

    assert_equal "Cornelius", merchant.name
  end

  def test_created_at_is_accurate
    merchant = Merchant.new("1", "Cornelius", "13:02", "13:03")

    assert_equal "13:02", merchant.created_at
  end

  def test_updated_at_is_accurate
    merchant = Merchant.new("1", "Cornelius", "13:02", "13:03")

    assert_equal "13:03", merchant.updated_at
  end

end
