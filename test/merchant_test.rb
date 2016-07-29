require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_we_can_instantiate_merchant_with_name
    m = Merchant.new({:name => "Gary"})
    assert_equal "Gary", m.name
  end

  def test_we_can_instantiate_merchant_with_different_name
    m = Merchant.new({:name => "Joe"})
    assert_equal "Joe", m.name
  end

  def test_we_can_instantiate_merchant_with_id
    m = Merchant.new({:id => 12345})
    assert_equal 12345, m.id
  end

  def test_we_can_instantiate_merchant_with_different_id
    m = Merchant.new({:id => 54321})
    assert_equal 54321, m.id
  end

  def test_we_can_instantiate_merchant_with_name_and_id
    m = Merchant.new({:name => "Pamela", :id => 90210})
    assert_equal "Pamela", m.name
    assert_equal 90210, m.id
  end

  def test_method_items_can_query_parent_of_merchant
    mock_mr = Minitest::Mock.new
    merchant = Merchant.new({id: 1}, mock_mr)
    mock_mr.expect(:find_all_items_by_merchant_id, nil, [1])
    merchant.items
    assert mock_mr.verify
  end
end
