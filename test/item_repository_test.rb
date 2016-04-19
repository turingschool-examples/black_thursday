require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    item1 = Item.new({:id => 12345, :name => "Pencil",
    :description => "You can use it to write things",
    :unit_price => BigDecimal.new(10.99,4),
    :merchant_id => 98765,
    :created_at => Time.now, :updated_at => Time.now})

    item2 = Item.new({:id => 12093, :name => "Pen",
    :description => "You can use it to write all the things",
    :unit_price => BigDecimal.new(8.99,3),
    :merchant_id => 235467,
    :created_at => Time.now, :updated_at => Time.now})

    @inventory = ItemRepository.new([item1, item2])
  end

  def test_it_created_instance_of_item_repo_class
    assert_equal ItemRepository, @inventory.class
  end

  def test_it_can_return_all_items_in_array_item_instances
    test_array = @inventory.all
    assert_equal 2, test_array.length
  end

  def test_it_can_find_an_instance_of_an_item_by_the_item_id
    item_instance = @inventory.find_by_id(12093)
    assert item_instance
    assert_equal "Pen", item_instance.name
  end

  def test_it_will_return_nil_if_item_id_does_not_exist
    item_instance = @inventory.find_by_id(120931235987)
    refute item_instance
    assert_equal nil, item_instance.name
  end

  def test_it_will_return_item_by_name
    item_instance = @inventory.find_by_name("Pen")
    assert item_instance
    assert_equal 12093, item_instance.id
  end

  def test_it_will_return_nil_if_item_name_does_not_exist
    item_instance = @inventory.find_by_name("Ball Point Pen")
    refute item_instance
    assert_equal nil, item_instance.name
  end

  def test_it_will_return_item_by_description
    item_instance = @inventory.find_by_description("You can use it to write all the things")
    assert item_instance
    assert_equal 12093, item_instance.id
  end

  def test_it_will_return_nil_if_item_description_does_not_exist
    item_instance = @inventory.find_by_description("This is the best pen ever!")
    refute item_instance
    assert_equal nil, item_instance.name
  end

  def test_it_will_return_item_by_price
    item_instance = @inventory.find_by_price(8.99)
    assert item_instance
    assert_equal 12093, item_instance.id
  end

  def test_it_will_return_nil_if_item_price_does_not_exist
    item_instance = @inventory.find_by_price(80.99)
    refute item_instance
    assert_equal nil, item_instance.name
  end

  def test_it_can_find_all_values_within_a_range
  end

  def test_it_can_find_one_value_in_the_range
  end

  def test_it_will_not_find_any_values_in_given_range
  end



end
