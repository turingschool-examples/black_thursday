require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
    @i = Item.new({:id => 12345, :name => "Pencil",
      :description => "You can use it to write things",
      # :unit_price => BigDecimal.new(10.99,4),
      :merchant_id => 98765,
      :created_at => Time.now, :updated_at => Time.now})
  end

  def test_it_created_instance_of_item_class
    assert_equal Item, @i.class
  end

  def test_it_returns_the_integer_id_of_the_item
    assert_equal 12345, @i.id
  end

  def test_it_returns_the_name_of_the_item
    assert_equal "Pencil", @i.name
  end

  def test_it_returns_the_description_of_the_item
    assert @i.description.include?("write")
  end

  def test_it_returns_price_of_item_formatted_as_big_decimal
    skip
    #figure out how big decimal works!
  end

  def test_it_returns_updated_time_later_than_time_created_at
  end

  def test_it_returns_merchant_id
    assert_equal 98765, @i.merchant_id
  end

  def test_it_can_return_unit_price_in_dollars
    #again figure out what this data means
  end


end
