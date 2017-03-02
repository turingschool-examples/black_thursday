require './test/test_helper'

class ItemRepositoryTest < Minitest::Test
  attr_reader :ir, :item_1, :item_2, :item_3, :items
  def setup
    @item_1 = Item.new(id:"263395617", name:"Glitter scrabble frames", description:"Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden", unit_price:"1300", merchant_id:"12334185", created_at:"2016-01-11 11:51:37 UTC", updated_at:"1993-09-29 11:56:40 UTC")
    @item_2 = Item.new(id:"263396013", name:"Free standing Woden letters", description:"Free standing wooden letters \n\n15cm\n\nAny colours", unit_price:"700", merchant_id:"12434185", created_at:"2016-01-11 11:51:36 UTC", updated_at:"2001-09-17 15:28:43 UTC")
    @item_3 = Item.new(id:"263398079", name:"HOT Dragon Wing Hand Blown Clear Glass Art Gold Trim Figurine Lucky Collection", description:"DESCRIPTION\n\nCondition: New\n\nApprox Size: W 1 5/8&quot;, L 1 1/2&quot;, H 2&quot;\nMaterial: BLOWN GLASS Painted", unit_price:"2390", merchant_id:"12334185", created_at:"2016-01-11 10:44:49 UTC", updated_at:"2007-12-06 19:17:12 UTC")
    @items = [item_1, item_2, item_3]
    @ir = ItemRepository.new(items)
  end

  def test_item_repo_exists
    assert ItemRepository
  end

  def test_all
    assert_equal items, ir.all
  end

  def test_find_by_id
    assert_equal item_2, ir.find_by_id(263396013)
  end

  def test_find_by_name
    assert_equal item_1, ir.find_by_name("Glitter scrabble frames")
  end

  def test_find_all_with_description
    assert_equal [item_3], ir.find_all_with_description("BLOWN GLASS Painted")
  end

  def test_find_all_with_description_returns_empty_arrry
    expected = []
    assert_equal expected, ir.find_all_with_description('puppies')
  end

  def test_find_all_by_price
    assert_equal [item_1], ir.find_all_by_price(BigDecimal.new("1300") / 100)
  end

  def test_find_all_by_price_returns_nil
    expected = []
    assert_equal expected, ir.find_all_by_price('10')
  end

  def test_find_all_by_price_in_range
    assert_equal [item_1, item_2], ir.find_all_by_price_in_range((BigDecimal.new(500)/100)..(BigDecimal.new(1500)/100))
  end

  def test_find_all_by_price_in_range_returns_nil
    expected = []
    assert_equal expected, ir.find_all_by_price_in_range((BigDecimal.new(50)/100)..(BigDecimal.new(150)/100))
  end

  def test_find_all_by_merchant_id
    expected = item_1, item_3
    assert_equal expected, ir.find_all_by_merchant_id(12334185)
  end

  def test_find_all_by_merchant_id
    expected = []
    assert_equal expected, ir.find_all_by_merchant_id(123345)
  end
end
