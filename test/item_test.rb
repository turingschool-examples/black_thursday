require_relative './../lib/item'
require_relative './test_helper'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'


class ItemTest < Minitest::Test

  def test_that_class_exist
    assert Item
  end

  def test_that_id_method_exist
    assert Item.method_defined? :id
  end

  def test_that_name_method_exist
    assert Item.method_defined? :name
  end

  def test_that_description_method_exist
    assert Item.method_defined? :description
  end

  def test_that_unit_price_method_exist
    assert Item.method_defined? :unit_price
  end

  def test_that_created_at_method_exist
    assert Item.method_defined? :created_at
  end

  def test_that_updated_at_method_exist
    assert Item.method_defined? :updated_at
  end

  def test_that_id_method_returns_item_id
    i = Item.new(id: 1, merchant_id: "10990")

    assert_equal 1, i.id
  end

  def test_that_name_method_returns_item_id
    i = Item.new(id: 1, merchant_id: "10990", name: "Pencil")

    assert_equal "Pencil", i.name
  end

  def test_that_description_method_exist__returns_description
    i = Item.new(id: 1, merchant_id: "10990", name: "Pencil", description: "You can use it to write things")

    assert_equal "You can use it to write things", i.description
  end

  def test_that_unit_price_method_returns_price
    i = Item.new(id: 1, merchant_id: "10990", name: "Pencil", description: "You can use it to write things", unit_price: 1000)

    assert_equal 1000, i.unit_price
  end

  def test_that_created_at_method_returns_time_when_item_was_created
    i = Item.new(id: 1, merchant_id: "10990", name: "Pencil", description: "You can use it to write things", unit_price: 1000, created_at: "1993-09-29 11:56:40 UTC")

    assert_equal "1993-09-29 11:56:40 UTC", i.created_at
  end

  def test_that_updated_at_method_returns_time_when_item_was_updated
    i = Item.new(id: 1, merchant_id: "10990", name: "Pencil", description: "You can use it to write things", unit_price: 1000, updated_at: "1993-09-29 11:56:40 UTC")

    assert_equal "1993-09-29 11:56:40 UTC", i.updated_at
  end
end
