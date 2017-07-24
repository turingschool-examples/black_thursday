require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'pry'

class ItemTest < Minitest::Test

  def test_it_exist
    item = Item.new({
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal.new(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now, })

    assert_instance_of Item, item
  end

  def test_it_has_a_name
    item = Item.new({
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal.new(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now, })

    assert_equal "Pencil", item.name
  end

  def test_it_has_a_description
    item = Item.new({
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal.new(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now, })
    assert_equal "You can use it to write things", item.description
  end


  def test_it_has_a_unit_price
    item = Item.new({
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal.new(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now, })
    assert_equal
  end


  def test_it_has_a_created_time
    item = Item.new({
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal.new(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now, })

  end

  def test_it_has_an_updated_time
    item = Item.new({
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal.new(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now, })

  end



end
