require 'pry'
require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'time'
require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/csv_adaptor'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repo'
require_relative '../lib/item'
require_relative '../lib/item_repo'

class ItemTest < Minitest::Test

  def test_it_exists
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    assert_instance_of Item, i
  end

  def test_it_returns_unit_price_in_dollar_format
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 6000,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    assert_equal 60.00, i.unit_price_to_dollars
  end


  def test_changing_attributes
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
    i.change_name("TEST")
    i.change_description("TEST")
    i.change_unit_price(1000000)
    i.change_updated_at

    assert_equal "TEST", i.name
    assert_equal "TEST", i.description
    assert_equal 1000000, i.unit_price
    refute i.updated_at == nil
  end

end
