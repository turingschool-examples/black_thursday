require './test/test_helper'
require './lib/merchant'

class MerchantTest < MiniTest::Test
  def setup
    @merchant ||= Merchant.new({
      :id          => 12335519,
      :name        => "Paul Bunyan Lake Creator",
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"})
  end

  def test_items
    # stub something out
    skip
    merchant_1 = stub(merchant: Mocha)
    assert_equal Mocha, merchant_1.merchant
  end

  def test_downcase_returns_a_lowercase_name
    assert_equal "paul bunyan lake creator", @merchant.downcaser
  end
end
