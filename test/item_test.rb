require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemsTest < Minitest::Test
  attr_reader :i
  def setup
    @i = Item.new({
      :name        => "Pencil",
      :id          => 100,
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 222
    })
  end

  def test_it_gets_items_csv
    result = {
      :name        => "Pencil",
      :id          => 100,
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 222
    }
    assert_equal result.inspect, i.item_hash.inspect
  end

  def test_it_gets_the_id
    assert_equal 100, i.id
  end

  def test_it_gets_the_name
    assert_equal 'Pencil', i.name
  end

  def test_it_gets_the_description
    assert_equal "You can use it to write things", i.description
  end

  def test_it_gets_the_unit_price
    assert_equal BigDecimal.new(1099), i.unit_price
  end

  def test_it_was_created_at
    assert_equal Time.now.inspect, i.created_at.inspect
  end

  def test_it_was_updated_at
    assert_equal Time.now.inspect, i.updated_at.inspect
  end

  def test_it_gets_the_merchant_id
    assert_equal 222, i.merchant_id
  end

  def test_it_converts_unit_price_to_dollars
    assert_equal 10.99, i.unit_price_to_dollars
  end
end
