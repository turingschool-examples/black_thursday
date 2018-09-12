require_relative  "test_helper"
require_relative '../lib/item_repository.rb'

class ItemRepositoryTest <  Minitest::Test

  def test_it_exists
    ir = ItemRepository.new('./data/items_tiny.csv', self)
    assert_instance_of ItemRepository, ir
  end

  def test_it_loads_items
    ir = ItemRepository.new('./data/items_tiny.csv', self)
    actual = ir.collection.length
    expected = 19
    assert_equal expected, actual
  end

  def test_crud_all
    ir = ItemRepository.new('./data/items_tiny.csv', self)
    actual = ir.all.length
    expected = 19
    assert_equal expected, actual
  end

  def test_crud_find_by_id
    ir = ItemRepository.new('./data/items_tiny.csv', self)
    actual = ir.find_by_id(263396013)[:id]
    require "pry"; binding.pry
    expected =
    assert_equal expected, actual
  end

  # def test_crud_find_by_name
  #   ir = ItemRepository.new('./data/items_tiny.csv', self)
  #   actual = ir.find_by_name("FREE standing WODEN letters")
  #   expected = {:id=>263396013,
  #     :name=>"Free standing Woden letters",
  #     :description=>"Free standing wooden letters\n\n15cm\n\nAny colours",
  #     :unit_price=>BigDecimal.new(700,0),
  #     :merchant_id=>"12334185",
  #     :created_at=>"2016-01-11 11:51:36 UTC",
  #     :updated_at=>"2001-09-17 15:28:43 UTC"}
  #   assert_equal expected, actual
  # end
  #
  # def test_find_all_with_description
  #   ir = ItemRepository.new('./data/items_tiny.csv', self)
  #   actual = ir.find_all_with_description("free standing")
  #   expected = [{:id=>263396013,
  #     :name=>"Free standing Woden letters",
  #     :description=>"Free standing wooden letters\n\n15cm\n\nAny colours",
  #     :unit_price=>BigDecimal.new(700,0),
  #     :merchant_id=>"12334185",
  #     :created_at=>"2016-01-11 11:51:36 UTC",
  #     :updated_at=>"2001-09-17 15:28:43 UTC"}]
  #   assert_equal expected, actual
  # end
  #
  # def test_delete
  #   ir = ItemRepository.new('./data/items_tiny.csv', self)
  #   assert_equal 19, ir.collection.length
  #   ir.delete(263396013)
  #   actual = ir.collection.length
  #   expected = 18
  #   assert_equal expected, actual
  # end
  #
  # def test_create
  #   ir = ItemRepository.new('./data/items_tiny.csv', self)
  #   ir.create({:id => 0, :name =>"Pencil", :description => "You can use it to write things", :unit_price => BigDecimal.new(10.99,4) , :created_at=> Time.now, :updated_at=> Time.now, :merchant_id => 2})
  #   actual = ir.collection.max_by {|element| element[:id]}[:id]
  #   expected = 263398180
  #   assert_equal expected, actual
  # end
  #
  # def test_update
  #   ir = ItemRepository.new('./data/items_tiny.csv', self)
  #   ir.update(263396013, [[:name, "Free standing Wooden letters"], [:unit_price, '600']])
  #   updated_item = ir.find_by_id(263396013)
  #   assert_equal "Free standing Wooden letters", updated_item[:name]
  #   assert_equal '600', updated_item[:unit_price]
  # end
  #
  # def test_find_all_by_price
  #   ir = ItemRepository.new('./data/items_tiny.csv', self)
  #   actual = ir.find_all_by_price(BigDecimal.new(700,0))
  #   expected = [{:id=>263396013,
  #     :name=>"Free standing Woden letters",
  #     :description=>"Free standing wooden letters\n\n15cm\n\nAny colours",
  #     :unit_price=>BigDecimal.new(700,0),
  #     :merchant_id=>"12334185",
  #     :created_at=>"2016-01-11 11:51:36 UTC",
  #     :updated_at=>"2001-09-17 15:28:43 UTC"}]
  #   assert_equal expected, actual
  # end
  #
  # def test_find_all_by_merchant_id
  #   ir = ItemRepository.new('./data/items_tiny.csv', self)
  #   actual = ir.find_all_by_merchant_id('12334257')
  #   require "pry"; binding.pry
  #   expected = [{:id=>263397843,
  #     :name=>"Wooden pen and stand",
  #     :description=>
  #     "Hand crafted wood pen made from T Tree\nVarious other woods available.\n\nRed gum (SA)\nSwan red gum (WA)\nBlackwood (TAS)\nAcacia (NT)\nForest red gum (TAS)\nT Tree (TAS)\n\nOther woods available on request\n\nAll pens are hand crafted and treated with local bees wax. These pens make great presents I can also have names etc lazier engraved for an extra $10.",
  #     :unit_price=>BigDecimal.new(4000,0),
  #     :merchant_id=>"12334257",
  #     :created_at=>"2016-01-11 11:44:00 UTC",
  #     :updated_at=>"2006-08-26 06:56:21 UTC"}]
  #   assert_equal expected, actual
  # end
  #
  # def test_find_all_by_price_in_range
  #   ir = ItemRepository.new('./data/items_tiny.csv', self)
  #   found = ir.find_all_by_price_in_range(1000.00..1500.00)
  #   actual = found.length
  #   expected = 4
  #   assert_equal expected, actual
  # end
end
