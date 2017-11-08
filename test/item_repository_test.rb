require_relative './test_helper'
require './lib/item_repository'

class TestItemRepository < Minitest::Test
  attr_reader :items

  def setup
    new_items = [{
      :id => '12345',
      :name => "Key Pad",
      :description => "Numberpad used for a fast lock",
      :unit_price => '500',
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
    parent = mock('parent')
    @items = ItemRepository.new(new_items, parent)
  end

  def test_setup_exists
    assert_instance_of ItemRepository, items
  end

  def test_item_has_all_method
    assert_equal 2, items.all.count
  end

  def test_can_find_item_by_id
    assert_equal 12345, items.find_by_id('12345').id
    assert_equal 23456, items.find_by_id('23456').id
  end

  def test_can_find_item_by_name
    assert_equal 'Key Pad', items.find_by_name('key pad').name
    assert_equal 'Nike Super Fast', items.find_by_name('Nike Super Fast').name
  end

  def test_can_find_all_by_description
    assert_equal 2, items.find_all_with_description('fast').count
  end

  def test_can_find_all_by_price
    assert_equal 'Key Pad', items.find_all_by_price(5).first.name
    assert_equal 'Nike Super Fast', items.find_all_by_price(100).first.name
    assert_equal [], items.find_all_by_price(250)
  end

  def test_can_find_all_by_price_in_range
    assert_equal 2, items.find_all_by_price_in_range(4..10001).count
    assert_equal 0, items.find_all_by_price_in_range(10..99).count
  end

  def test_can_find_by_merchant_id
    assert_equal 1, items.find_all_by_merchant_id(65432).count
    assert_equal [], items.find_all_by_merchant_id(12393)
  end

  def test_can_use_find_merchant_by_id
    items.parent.stubs(:find_merchant_by_id).with(54321).returns(true)

    assert items.find_merchant_by_id(54321)
  end
end
