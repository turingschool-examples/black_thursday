require 'simplecov'
SimpleCov.start
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryClassTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.new
    item1 = Item.new("", {:id => 2342,
                     :name => "MY Item",
                     :description => "Best item ever",
                     :unit_price => 1500,
                     :merchant_id => 23,
                     :created_at => Time.now,
                     :updated_at => Time.now})
    item2 = Item.new("", {:id => 2341,
                     :name => "Another item",
                     :description => "Mediocre item",
                     :unit_price => 1200,
                     :merchant_id => 22,
                     :created_at => Time.now,
                     :updated_at => Time.now})
   item3 = Item.new("", {:id => 2438,
                    :name => "Tertiary item",
                    :description => "This is an item",
                    :unit_price => 1100,
                    :merchant_id => 22,
                    :created_at => Time.now,
                    :updated_at => Time.now})
    @items = [item1, item2, item3]
    @item_repository = ItemRepository.new(@sales_engine)

    @items.each { |item| @item_repository.repository << item }
    # binding.pry
  end

  def test_can_initialize_an_item_repository_and_it_exists
    assert item_repository = ItemRepository.new(@sales_engine)
    assert_equal [], item_repository.repository
  end

  def test_can_get_an_array_of_all_items_in_the_item_repository
    expected = "[  id: 2342
    name: MY Item
    description: Best item ever
    unit price: 0.15E2
    merchant id: 23
    created at: #{Time.now}
    updated at: #{Time.now},   id: 2341
    name: Another item
    description: Mediocre item
    unit price: 0.12E2
    merchant id: 22
    created at: #{Time.now}
    updated at: #{Time.now},   id: 2438
    name: Tertiary item
    description: This is an item
    unit price: 0.11E2
    merchant id: 22
    created at: #{Time.now}
    updated at: #{Time.now}]"
    assert_equal expected, @item_repository.all.to_s
  end

  def test_find_by_id
    expected = "  id: 2342
    name: MY Item
    description: Best item ever
    unit price: 0.15E2
    merchant id: 23
    created at: #{Time.now}
    updated at: #{Time.now}"
    assert_equal expected, @item_repository.find_by_id(2342).inspect.to_s
  end

  def test_find_by_name
    expected = "  id: 2342
    name: MY Item
    description: Best item ever
    unit price: 0.15E2
    merchant id: 23
    created at: #{Time.now}
    updated at: #{Time.now}"
    assert_equal expected, @item_repository.find_by_name("MY Item").inspect.to_s
  end

  def test_find_all_with_description
    expected = "[  id: 2342
    name: MY Item
    description: Best item ever
    unit price: 0.15E2
    merchant id: 23
    created at: #{Time.now}
    updated at: #{Time.now},   id: 2341
    name: Another item
    description: Mediocre item
    unit price: 0.12E2
    merchant id: 22
    created at: #{Time.now}
    updated at: #{Time.now},   id: 2438
    name: Tertiary item
    description: This is an item
    unit price: 0.11E2
    merchant id: 22
    created at: #{Time.now}
    updated at: #{Time.now}]"
    assert_equal expected, @item_repository.find_all_with_description("item").to_s
  end

  def test_find_all_by_price
    expected = "[  id: 2341
    name: Another item
    description: Mediocre item
    unit price: 0.12E2
    merchant id: 22
    created at: #{Time.now}
    updated at: #{Time.now}]"
    assert_equal expected, @item_repository.find_all_by_price(12).to_s
  end

  def test_find_all_by_price_in_range
    expected = "[  id: 2341
    name: Another item
    description: Mediocre item
    unit price: 0.12E2
    merchant id: 22
    created at: #{Time.now}
    updated at: #{Time.now},   id: 2438
    name: Tertiary item
    description: This is an item
    unit price: 0.11E2
    merchant id: 22
    created at: #{Time.now}
    updated at: #{Time.now}]"
    assert_equal expected, @item_repository.find_all_by_price_in_range(10..12).to_s
  end

  def test_find_all_by_merchant_id
    expected = "[  id: 2341
    name: Another item
    description: Mediocre item
    unit price: 0.12E2
    merchant id: 22
    created at: #{Time.now}
    updated at: #{Time.now},   id: 2438
    name: Tertiary item
    description: This is an item
    unit price: 0.11E2
    merchant id: 22
    created at: #{Time.now}
    updated at: #{Time.now}]"
    assert_equal expected, @item_repository.find_all_by_merchant_id(22).to_s
  end


end
