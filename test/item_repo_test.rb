require './test/test_helper'
require './lib/item_repo'
class ItemRepoTest < Minitest::Test

  def test_add_items_and_access_them
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    assert_equal 1, ir.all.count
    assert_equal "Awesome thing", ir.all.first.name
  end

  def test_find_by_id
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn..."})
    assert_equal "Awesome thing", ir.find_by_id(123).name
  end

  def test_fail_at_find_by_id
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn..."})
    assert_equal nil, ir.find_by_id(0)
  end

  def test_find_by_name
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn..."})
    assert_equal 124, ir.find_by_name("YARN").id
  end

  def test_fail_at_find_by_name
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn..."})
    assert_equal nil, ir.find_by_name("carrot")
  end

  def test_find_all_with_description
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn..."})
   ir.add_item({:id => 125,
                :name => "yarn!",
                :description => "it's really cool yarn"})
    found_items = ir.find_all_with_description("yarn")
    assert_equal [], ir.find_all_with_description("foo")
    assert_equal 2, found_items.count
    assert_equal 124, found_items.first.id
  end

  def test_find_all_by_price
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn...",
                 :unit_price => 150})
    ir.add_item({:id => 125,
                :name => "yarn!",
                :description => "it's really cool yarn",
                :unit_price => 150})
    assert_equal [], ir.find_all_by_price(100)
    assert_equal 2, ir.find_all_by_price(150).count
  end

  def test_find_all_by_price_in_range
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn...",
                 :unit_price => 150})
    ir.add_item({:id => 125,
                :name => "yarn!",
                :description => "it's really cool yarn",
                :unit_price => 140})
    assert_equal [], ir.find_all_by_price_in_range((1..10))
    assert_equal 2, ir.find_all_by_price_in_range((130..150)).count
  end

  def test_find_all_by_merchant_id
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn...",
                 :unit_price => 150,
                 :merchant_id => 4})
    ir.add_item({:id => 125,
                :name => "yarn!",
                :description => "it's really cool yarn",
                :unit_price => 140,
                :merchant_id => 4})
    assert_equal [], ir.find_all_by_merchant_id(666)
    assert_equal 2, ir.find_all_by_merchant_id(4).count
  end

end
