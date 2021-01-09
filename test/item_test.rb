require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  def test_it_exist_and_has_attributes
    i = Item.new({
                  :id          => 2,
                  :name        => 'Pencil',
                  :description => 'You can use it to write things',
                  :unit_price  => BigDecimal(10.99,4),
                  :merchant_id => 1,
                  :created_at  => '2021-01-06 11:29:55 UTC',
                  :updated_at  => '2021-01-06 11:29:55 UTC'
                })

    assert_instance_of Item, i
    assert_equal 2, i.id
    assert_equal 'Pencil', i.name
    assert_equal 'You can use it to write things', i.description
    assert_equal (0.10), i.unit_price
    assert_equal 1, i.merchant_id
    assert_equal Time.parse('2021-01-06 11:29:55 UTC'), i.created_at
    assert_equal Time.parse('2021-01-06 11:29:55 UTC'), i.updated_at
  end

  def test_unit_price_to_dollars
    i = Item.new({
                  :id          => 2,
                  :name        => 'Pencil',
                  :description => 'You can use it to write things',
                  :unit_price  => BigDecimal(10.99,4),
                  :merchant_id => 1,
                  :created_at  => '2021-01-06 11:29:55 UTC',
                  :updated_at  => '2021-01-06 11:29:55 UTC'
                })

    assert_equal (0.10), i.unit_price_to_dollars
  end
end
