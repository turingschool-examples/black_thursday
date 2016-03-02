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
      # :unit_price => 1200
      })

    assert_equal 4, item[:id]
    assert_equal "Pencil", item[:name]
    assert_equal "You can use it to write", item[:description]
  end

end
