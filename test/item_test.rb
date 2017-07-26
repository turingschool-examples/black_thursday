require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def test_it_takes_hash
    i = Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.parse("2016-11-01 11:38:28 -0600"),
  :updated_at  => Time.parse("2016-11-01 11:38:28 -0600")
})

    assert_equal "Pencil", i.name
    assert_equal "You can use it to write things", i.description
    assert_equal BigDecimal.new(10.99,4), i.unit_price

  end

   def test_time_takes_data
     i = Item.new({:name        => "Pencil",
                   :description => "You can use it to write things",
                   :unit_price  => BigDecimal.new(10.99,4),
                   :created_at  => Time.parse("2016-11-01 11:38:28 -0600"),
                   :updated_at  => Time.parse("2016-11-01 11:38:28 -0600")
                 })
     expected = Time.parse("2016-11-01 11:38:28 -0600")

     assert_equal expected, i.created_at
     assert_instance_of Time, i.created_at
   end

 end
