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

  # def test_items_returns_an_array_of_all_merchants_items
  #   id = 12334105
  #   item_1 = stub(:merchant_id => id)
  #   item_2 = stub(:merchant_id => id)
  #   merchant_repository = stub(:find_items_by_id(id) => [item_1, item_2])
  #   m = Merchant.new({:id => id, :name => "Shopin1901"}, merchant_repository)
  #
  #   assert m.items.all? do |item|
  #     item.merchant_id == m.id
  #   end
  # end
end
