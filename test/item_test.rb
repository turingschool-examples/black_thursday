require_relative './../lib/item'
require_relative 'spec_helper'
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
    i = Item.new(id: 1, merchant_id: "10990", unit_price: 1000, :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC")

    assert_equal 1, i.id
  end

  def test_that_name_method_returns_item_id
    i = Item.new(id: 1, merchant_id: "10990", name: "Pencil", unit_price: 1000, :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC")

    assert_equal "Pencil", i.name
  end

  def test_that_description_method_exist__returns_description
    i = Item.new(id: 1, merchant_id: "10990", name: "Pencil", description: "You can use it to write things", unit_price: 1000, :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC")

    assert_equal "You can use it to write things", i.description
  end

  def test_that_unit_price_method_returns_price
    i = Item.new(id: 1, merchant_id: "10990", name: "Pencil", description: "You can use it to write things", unit_price: 1000, :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC")

    assert_equal 10.0, i.unit_price
  end

  def test_that_created_at_method_returns_time_when_item_was_created
    i = Item.new(id: 1, merchant_id: "10990", name: "Pencil", description: "You can use it to write things", unit_price: 1000, :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC")

    assert_equal Time.parse("2016-01-11 10:37:09 UTC"), i.created_at
  end

  def test_that_updated_at_method_returns_time_when_item_was_updated
    i = Item.new(id: 1, merchant_id: "10990", name: "Pencil", description: "You can use it to write things", unit_price: 1000, :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC")

    assert_equal Time.parse("2016-01-11 10:37:09 UTC"), i.updated_at
  end

  def test_that_merchant_id_can_be_called
    i = Item.new(id: 1, merchant_id: "10990", name: "Pencil", description: "You can use it to write things", unit_price: 1000, :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC")


    assert_equal 10990, i.merchant_id
  end
end
