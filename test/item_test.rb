require_relative 'test_helper.rb'
require_relative '../lib/item.rb'

class ItemTest < Minitest::Test
  def test_it_exists
    item_one = Item.new({ :id          => 1,
                          :name        => "Pencil",
                          :description => "You can use it to write things",
                          :unit_price  => 1099,
                          :created_at  => Time.now,
                          :updated_at  => Time.now,
                          :merchant_id => 12334141
                        })

    assert_instance_of Item, item_one
  end

  def test_it_has_an_id
    item_one = Item.new({
                          :id          => 1,
                          :name        => "Pencil",
                          :description => "You can use it to write things",
                          :unit_price  => 1099,
                          :created_at  => Time.now,
                          :updated_at  => Time.now,
                          :merchant_id => 12334141
                        })

    assert_equal 1, item_one.id
  end

  def test_it_has_a_name
    item_one = Item.new({
                          :id          => 1,
                          :name        => "Pencil",
                          :description => "You can use it to write things",
                          :unit_price  => 1099,
                          :created_at  => Time.now,
                          :updated_at  => Time.now,
                          :merchant_id => 12334141
                        })

    assert_equal "Pencil", item_one.name
  end

  def test_it_has_a_description
    item_one = Item.new({
                          :id          => 1,
                          :name        => "Pencil",
                          :description => "You can use it to write things",
                          :unit_price  => 1099,
                          :created_at  => Time.now,
                          :updated_at  => Time.now,
                          :merchant_id => 12334141
                        })
    expected = "You can use it to write things"

    assert_equal expected, item_one.description
  end

  def test_it_has_a_unit_price
    item_one = Item.new({
                          :id          => 1,
                          :name        => "Pencil",
                          :description => "You can use it to write things",
                          :unit_price  => 1099,
                          :created_at  => Time.now,
                          :updated_at  => Time.now,
                          :merchant_id => 12334141
                        })

    assert_equal 10.99, item_one.unit_price
    assert_instance_of BigDecimal, item_one.unit_price
  end

  def test_it_has_a_date
    item_one = Item.new({
                          :id          => 1,
                          :name        => "Pencil",
                          :description => "You can use it to write things",
                          :unit_price  => 1099,
                          :created_at  => Time.now,
                          :updated_at  => Time.now,
                          :merchant_id => 12334141
                        })

    assert_instance_of Time, item_one.created_at
  end

  def test_it_has_an_updated_at_value
    item_one = Item.new({
                          :id          => 1,
                          :name        => "Pencil",
                          :description => "You can use it to write things",
                          :unit_price  => 1099,
                          :created_at  => Time.now,
                          :updated_at  => Time.now,
                          :merchant_id => 12334141
                        })

    assert_instance_of Time, item_one.updated_at
  end

  def test_it_has_a_merchant_id
    item_one = Item.new({
                          :id          => 1,
                          :name        => "Pencil",
                          :description => "You can use it to write things",
                          :unit_price  => 1099,
                          :created_at  => Time.now,
                          :updated_at  => Time.now,
                          :merchant_id => 12334141
                        })

    assert_equal 12334141, item_one.merchant_id
  end

  def test_unit_price_to_dollars_converts_unit_price_to_dollar_float
    skip
    item_one = Item.new({
                          :id          => 1,
                          :name        => "Pencil",
                          :description => "You can use it to write things",
                          :unit_price  => 10,
                          :created_at  => Time.now,
                          :updated_at  => Time.now,
                          :merchant_id => 12334141
                        })

      assert_equal 10.00, item_one.unit_price_to_dollars
  end
end
