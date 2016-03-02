require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'time'
require 'bigdecimal'
require 'pry'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def test_initalize_organizes_row_values
    item = Item.new ({
      :id => 4,
      :name => "Pencil",
      :description => "You can use it to write",
      :unit_price => 1200
      :created_at => "2016-01-11 11:51:37 UTC"
      :updated_at => "1995-03-19 10:02:43 UTC"
      :merchant_id => "12334105"
      })

    assert_equal "4", item[:id]
    assert_equal "Pencil", item[:name]
    assert_equal "You can use it to write", item[:description]
    assert_equal 1200, item[:unit_price]
    assert_equal "2016-01-11 11:51:37 UTC", item[:created_at]
    assert_equal "1995-03-19 10:02:43 UTC", item[:updated_at]
  end

  def test_returns_price_in_dollars_formatted_as_float
    item =k Item.new({
      :id => 4,
      :name => "Pencil",
      :description => "You can use it to write",
      :unit_price => 1200
      :created_at => "2016-01-11 11:51:37 UTC"
      :updated_at => "1995-03-19 10:02:43 UTC"
      :merchant_id => "12334105"
      })
    assert_equal "$1200.0", item.unit_price_per_dollarsk   
  end

end
