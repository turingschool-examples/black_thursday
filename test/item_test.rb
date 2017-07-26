require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'


class ItemTest < Minitest::Test

  def setup
    hash = {id: 1, name: "Candy", description: "yellow",
            unit_price: 120, merchant_id: 13,
            created_at: Time.now, updated_at: Time.now   }
    @the_item = Item.new(hash)
  end

  def test_it_has_id
    assert_equal 1, @the_item.id
  end

  def test_it_has_name
    assert_equal "Candy", @the_item.name
  end

  def test_it_has_descriptions
    assert_equal "yellow", @the_item.description
  end

  def test_it_has_unit_price
    assert_equal 120, @the_item.unit_price
  end


  def test_it_has_merchant_id
    assert_equal 13, @the_item.merchant_id
  end

  def test_it_has_created_at
    assert_instance_of Time, @the_item.created_at
  end

  def test_it_has_updated_at
    assert_instance_of Time, @the_item.updated_at
  end

  def test_it_is_initialized_corretly
    hash = {}
    item = Item.new(hash)
    assert item
    assert_instance_of Item, item
  end

end
