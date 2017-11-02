require_relative './test_helper'
require './lib/item_repository'

class TestItemRepository < Minitest::Test
  def setup
    items = [{
      :id => '12345',
      :name => "Key Pad",
      :description => "Numberpad used for a fast lock",
      :unit_price => '5',
      :merchant_id => '54321',
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
    },{
      :id => '23456',
      :name => 'Nike Super Fast',
      :description => 'Really fast shoes',
      :unit_price => '10000',
      :merchant_id => '65432',
      :created_at => '2016-01-11 09:34:06 UTC',
      :updated_at => '2007-06-04 21:35:10 UTC'
    }]
    ItemRepository.new(items, self)
  end

  def test_setup_exists
    ir = setup
    assert_instance_of ItemRepository, ir
  end

  def test_item_has_all_method
    ir = setup

    assert_equal 2, ir.all.count
  end

  def test_can_find_item_by_id
    ir = setup

    assert_equal '12345', ir.find_by_id('12345').id
    assert_equal '23456', ir.find_by_id('23456').id
  end

  def test_can_find_item_by_name
    ir = setup

    assert_equal 'Key Pad', ir.find_by_name('key pad').name
    assert_equal 'Nike Super Fast', ir.find_by_name('Nike Super Fast').name
  end

  def test_can_find_all_by_description
    ir = setup

    assert_equal 2, ir.find_all_with_description('fast').count
  end

  def test_can_find_all_by_price
    ir = setup

    assert_equal 'Key Pad', ir.find_all_by_price(5)[0].name
    assert_equal 'Nike Super Fast', ir.find_all_by_price(10000)[0].name
    assert_equal [], ir.find_all_by_price(250)
  end

  def test_can_find_all_by_price_in_range
    ir = setup

    assert_equal 2, ir.find_all_by_price_in_range(10001, 4).count
    assert_equal 0, ir.find_all_by_price_in_range(500, 100).count
  end

  def test_can_find_by_merchant_id
    ir = setup

    assert_equal 1, ir.find_all_by_merchant_id(65432).count
    assert_equal [], ir.find_all_by_merchant_id(12393)
  end
end
