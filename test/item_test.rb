require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def setup
    
    @decimal = BigDecimal.new(10.99, 4)
    @created = Time.new(2018, 9, 7)
    @updated = Time.new(2018, 9, 8)

    input = {
      :id => 1, 
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => @decimal,
      :created_at => @created,
      :updated_at => @updated,
      :merchant_id => 2
    }
    
    @m = Item.new(input)
  end

  def test_it_exists
    assert_instance_of Item, @m
  end

  def test_it_has_attributes
    assert_equal 1, @m.id
    assert_equal @created, @m.created_at
    assert_equal 2, @m.merchant_id

    assert_equal "Pencil", @m.name
    assert_equal "You can use it to write things", @m.description
    assert_equal @decimal, @m.unit_price
    assert_equal @updated, @m.updated_at
  end


end