require_relative 'test_helper.rb'
require_relative '../lib/item.rb'

class ItemTest < Minitest::Test
  attr_reader :item_one

  def setup 
    @item_one = Item.new({ :id         => 1,
                          :name        => "Pencil",
                          :description => "You can use it to write things",
                          :unit_price  => 1099,
                          :created_at  => Time.now,
                          :updated_at  => Time.now,
                          :merchant_id => 12334141})
  end

  def test_it_exists
    assert_instance_of Item, item_one
  end

  def test_it_has_an_id
    assert_equal 1, item_one.id
  end

  def test_it_has_a_name
    assert_equal "Pencil", item_one.name
  end

  def test_it_has_a_description
    expected = "You can use it to write things"

    assert_equal expected, item_one.description
  end

  def test_it_has_a_unit_price
    assert_equal 10.99, item_one.unit_price
    assert_instance_of BigDecimal, item_one.unit_price
  end

  def test_it_has_a_date
    assert_instance_of Time, item_one.created_at
  end

  def test_it_has_an_updated_at_value
    assert_instance_of Time, item_one.updated_at
  end

  def test_it_has_a_merchant_id
    assert_equal 12334141, item_one.merchant_id
  end
end