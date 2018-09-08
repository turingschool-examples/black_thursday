require './test/minitest_helper'
require './lib/item'



class ItemTest<Minitest::Test

  def test_it_exists
      i = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal.new(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
        })

      assert_instance_of Item, i
  end
  #
  # def test_it_has_attributes
  #   item = Item.new(ITEM_DATA)
  #
  #   assert_equal 263_538_760, item.id
  #   assert_equal 'Pencil', item.name
  #   assert_equal 'You can use it to write things', item.description
  #   assert_instance_of BigDecimal, item.unit_price
  #   assert_equal 12_334_185, item.merchant_id
  #   assert_instance_of Time, item.created_at
  #   assert_instance_of Time, item.updated_at
  # end

end
