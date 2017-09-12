require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def setup
    item = Item.new({
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal.new(10.99,4),
          :created_at  => '12:00',
          :updated_at  => '8:00',
          })
    item
  end 

  def test_it_exists
    item = setup
    
    assert_instance_of Item, item
  end

  def test_it_displays_id
    item = setup
    
    #assert_equal ,item.id
  end

  def test_it_has_a_name
    item = setup  

    assert_equal 'Pencil', item.name
  end
  
  def test_it_has_a_description
    item = setup

    assert_equal "You can use it to write things", item.description
  end
  
  def test_it_has_a_unit_price
    item = setup

    assert_equal BigDecimal.new(10.99,4), item.unit_price
  end

  def test_it_has_a_created_at_time
    item = setup

    assert_equal '12:00', item.created_at
  end

  def test_it_has_an_updated_at_time
    item = setup

    assert_equal '8:00', item.updated_at
  end


end
