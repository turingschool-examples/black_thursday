require 'CSV'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/items'


class ItemTest < Minitest::Test

  def setup
    @data = Item.new({
      :id => 1,
      :name => "Bat",
      :description => "long and slim",
      :unit_price => 25,
      :merchant_id => 0101,
      :created_at => "AZ",
      :updated_at => "CO"})

      assert_instance_of Item, @data
  end

  def test_it_exists
    @data

    assert_equal 1, @data.id
    assert_equal "Bat", @data.name
    assert_equal "long and slim", @data.description
    assert_equal 25, @data.unit_price
    assert_equal 0101, @data.merchant_id
    assert_equal "AZ", @data.created_at
    assert_equal "CO", @data.updated_at
  end

end
