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

  def test_it_has_attributes
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
      })

    assert_equal 1, i.id
    assert_equal 'Pencil', i.name
    assert_equal 'You can use it to write things', i.description
    assert_instance_of BigDecimal, i.unit_price
    assert_instance_of Time, i.created_at
    assert_instance_of Time, i.updated_at
    assert_equal 2, i.merchant_id
  end

end
