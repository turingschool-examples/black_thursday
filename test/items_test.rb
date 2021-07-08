require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/items'

class ItemTest < Minitest::Test

  def test_it_takes_hash
    i = Item.new({
                  :name        => "Shirt",
                  :description => "random csv thing",
                  :unit_price  => "5",
                  :created_at  => Time.parse("2017-09-20 12:00:00 -0600"),
                  :updated_at  => Time.parse("2017-09-20 12:00:00 -0600")
                  })

    assert_equal "Shirt", i.name
    assert_equal "random csv thing", i.description
    assert_equal BigDecimal, i.unit_price.class

  end

   def test_time_takes_data
     i = Item.new({:name        => "Shirt",
                   :description => "random csv thing",
                   :unit_price  => "5",
                   :created_at  => Time.parse("2016-11-01 11:38:28 -0600"),
                   :updated_at  => Time.parse("2016-11-01 11:38:28 -0600")
                 })
     expected = Time.parse("2016-11-01 11:38:28 -0600")

     assert_equal expected, i.created_at
     assert_instance_of Time, i.created_at
   end


   def test_it_can_change_to_dollar_format
     i = Item.new({:name        => "Shirt",
                   :description => "random csv thing",
                   :unit_price  => 5000,
                   :created_at  => Time.parse("2017-12-09 12:00:00 -0600"),
                   :updated_at  => Time.parse("2017-12-09 12:00:00 -0600")
                 })
     assert_equal 50.00, i.unit_price_to_dollars(5000)
   end

end
