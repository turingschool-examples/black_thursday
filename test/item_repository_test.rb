require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    item1 = Item.new({:id => 12345, :name => "Pencil",
    :description => "You can use it to write things",
    :unit_price => BigDecimal.new(1099,4),
    :merchant_id => 98765,
    :created_at => Time.new.to_s, :updated_at => Time.new.to_s
    })

    item2 = Item.new({:id => 12093, :name => "Pen",
    :description => "You can use it to write all the things",
  :unit_price => BigDecimal.new(899,3),
    :merchant_id => 235467,
    :created_at => Time.new.to_s, :updated_at => Time.new.to_s
    })

    @inventory = ItemRepository.new
    @inventory.item_repository = ([item1, item2])
  end

  def test_it_created_instance_of_item_repo_class
    assert_equal ItemRepository, @inventory.class
  end

  def test_it_can_return_all_items_in_array_item_instances
    test_array = @inventory.all
    assert_equal 2, test_array.length
  end

  def test_it_will_return_nil_if_no_item_instances
    new_inventory = ItemRepository.new({})
    assert_equal nil, new_inventory.all
  end

  def test_it_can_find_an_instance_of_an_item_by_the_item_id
    item_instance = @inventory.find_by_id(12093)
    assert item_instance
    assert_equal "Pen", item_instance.name
  end

  def test_it_will_return_nil_if_item_id_does_not_exist
    item_instance = @inventory.find_by_id(120931235987)
    refute item_instance
    assert_equal nil, item_instance
  end

  def test_it_will_return_item_by_name
    item_instance = @inventory.find_by_name("Pen")
    assert item_instance
    assert_equal 12093, item_instance.id
  end

  def test_it_will_work_if_given_name_is_uppercase
    item_instance = @inventory.find_by_name("PEN")
    assert item_instance
    assert_equal 12093, item_instance.id
  end

  def test_it_will_return_nil_if_item_name_does_not_exist
    item_instance = @inventory.find_by_name("Ball Point Pen")
    refute item_instance
    assert_equal nil, item_instance
  end

  def test_it_will_return_item_by_description
    item_instance = @inventory.find_all_with_description("You can use it to write all the things")
    assert item_instance
  end

  def test_it_will_return_item_by_description_case_insensitive
    item_instance = @inventory.find_all_with_description("YoU CaN uSe IT tO wRIte aLL THe ThINgs")
    assert item_instance
  end

  def test_it_will_return_nil_if_item_description_does_not_exist
    item_instance = @inventory.find_all_with_description("This is the best pen ever!")
    assert_equal [], item_instance
  end

  def test_it_will_return_item_by_price
    item_instance = @inventory.find_all_by_price(8.99)
    assert item_instance
    assert_equal 12093, item_instance[0].id
  end

  def test_it_will_return_nil_if_item_price_does_not_exist
    item_instance = @inventory.find_all_by_price(80.99)
    assert_equal [], item_instance
  end

  def test_it_can_find_all_values_within_a_range
    item_instance = @inventory.find_all_by_price_in_range(7..11)
    assert_equal 2, item_instance.length
    assert_equal "Pencil", item_instance[0].name
  end

  def test_it_can_find_one_value_in_the_range
    item_instance = @inventory.find_all_by_price_in_range(10..11)
    assert_equal 1, item_instance.length
    assert_equal "Pencil", item_instance[0].name
  end

  def test_it_will_not_find_any_values_in_given_range
    item_instance = @inventory.find_all_by_price_in_range(12..15)
    assert_equal [], item_instance
  end

  def test_it_will_find_all_by_merchant_id
    item_instance = @inventory.find_all_by_merchant_id(98765)
    assert item_instance
    assert_equal "Pencil", item_instance[0].name
  end

  def test_it_will_return_empty_array_if_merchant_id_doesnt_exist
    item_instance = @inventory.find_all_by_merchant_id(120931235987)
    assert_equal [], item_instance
  end

end
