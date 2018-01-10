require './test/test_helper'
require './lib/merchant'

class MerchantTest < MiniTest::Test
  def setup
    parent = stub(items_by_id: "Items")
    @merchant = Merchant.new({
      :id          => 12335519,
      :name        => "Paul Bunyan Lake Creator",
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"}, parent)
  end

  def test_items_returns_items
    assert_equal "Items", @merchant.items
  end

  def test_downcase_returns_a_lowercase_name
    assert_equal "paul bunyan lake creator", @merchant.downcaser
  end
end
