require 'pry'

require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < MiniTest::Test

  def test_if_create_class
    i = Item.new("pencil", "test", 10.99, Time.now, Time.now)

    assert_instance_of Item, i
  end

  def test_default_attributes
    # i = Item.new({:name        => "Pencil",
    #               :description => "You can use it to write things",
    #               :unit_price  => BigDecimal.new(10.99,4),
    #               :created_at  => Time.now,
    #               :updated_at  => Time.now
    #              })
    i = Item.new("pencil", "test", 10.99, Time.now, Time.now)


    assert i.name
    assert i.description
    assert i.unit_price
    assert i.created_at
    assert i.updated_at
  end

end
