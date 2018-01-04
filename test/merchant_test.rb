require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_id
    m = Merchant.new({:id => 5, :name => "Turing School"}, mock('MerchantRepository'))

    assert_equal 5, m.id
  end

  def test_it_has_name
    m = Merchant.new({:id => 5, :name => "Turing School"}, mock('MerchantRepository'))

    assert_equal "Turing School", m.name
  end

  def test_it_calls_merchant_repository_to_return_array_of_all_items
    item = mock('item')
    mr = mock('MerchantRepository')
    mr.expects(:find_items_by_id).returns([item, item, item])
    m = Merchant.new({:id => 12334105, :name => "Shopin1901"}, mr)

    assert_equal [item, item, item], m.items
  end
end
