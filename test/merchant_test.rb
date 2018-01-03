require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_id
    m = Merchant.new({:id => 5, :name => "Turing School"}, mock('MerchantRepository'))

    assert_equal 5, m.id
  end

  def test_it_has_name
    m = Merchant.new({:id => 5, :name => "Turing School"}, mock('MerchantRepository'))

    assert_equal "Turing School", m.name
  end

  def test_items_returns_an_array_of_all_merchants_items
    id = 12334105
    mr = mock('MerchantRepository')
    mr.expects(:find_items_by_id).with(id).at_least_once
    m = Merchant.new({:id => id, :name => "Shopin1901"}, mr)
    m.items
  end
end
