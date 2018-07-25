require 'pry'
require './lib/item'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'


class ItemTest < MiniTest::Test

  def test_existence
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

  def test_id
      i = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal.new(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
                  })
    result = i.id
    expected = 1
    assert_equal expected, result
  end

  def test_name
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                })
    expected = "Pencil"
    result = i.name
    assert_equal expected, result
  end

  def test_description
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                })
    expected = "You can use it to write things"
    result = i.description
    assert_equal expected, result
  end

  def test_unit_price
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                })
    expected = 0.1099
    result = i.unit_price
    assert_equal expected, result
  end

  def test_merchant_id
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                })
    expected = 2
    result = i.merchant_id
    assert_equal expected, result
  end

  def test_unit_price_in_dollars
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                })
    expected = 0.1099
    result = i.unit_price_to_dollars
    assert_equal expected, result
  end
end
