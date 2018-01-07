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

  def test_it_finds_average_item_price
    m = Merchant.new({:id => 12334105, :name => "Shopin1901"}, mock('MerchantRepository'))
    item_1 = stub(:unit_price => 29.99)
    item_2 = stub(:unit_price => 9.99)
    item_3 = stub(:unit_price => 9.99)
    m.stubs(:items).returns([item_1, item_2, item_3])

    assert_equal BigDecimal.new((0.16656666666666666e2).to_s), m.average_item_price
  end

  def test_it_calls_merchant_repository_to_return_array_of_all_items
    item = mock('item')
    mr = mock('MerchantRepository')
    mr.expects(:find_items_by_id).returns([item, item, item])
    m = Merchant.new({:id => 12334105, :name => "Shopin1901"}, mr)

    assert_equal [item, item, item], m.items
  end
end
