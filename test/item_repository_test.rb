require_relative './test_helper'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    item_repository = ItemRepository.new('./short_tests/short_items.csv')

    assert_instance_of ItemRepository, item_repository
  end

  def test_it_can_load_items
    item_repository = ItemRepository.new('./short_tests/short_items.csv')

    assert_instance_of Array, item_repository.all
  end

  def test_it_can_find_by_id
    item_repository = ItemRepository.new('./short_tests/short_items.csv')

    actual = item_repository.find_by_id(1)
    assert_instance_of Item, actual
    assert_equal "card", actual.name
  end

  def test_it_returns_nil_if_cant_find_id
    item_repository = ItemRepository.new('./short_tests/short_items.csv')

    actual = item_repository.find_by_id(11)
    assert_nil actual
  end

  def test_it_can_find_by_name
    item_repository = ItemRepository.new('./short_tests/short_items.csv')

    actual = item_repository.find_by_name("card")
    assert_instance_of Item, actual
    assert_equal 1, actual.id
  end

  def test_find_name_can_return_nil
    item_repository = ItemRepository.new('./short_tests/short_items.csv')

    actual = item_repository.find_by_name("Samuel")
    assert_nil actual
  end

  def test_it_can_find_all_with_description
    item_repository = ItemRepository.new('./short_tests/short_items.csv')
    description = "has flamingos on it"
    item_1 = item_repository.find_by_id(5)
    assert_equal [item_1], item_repository.find_all_with_description(description)
  end

  def test_it_can_find_all_with_desctiption_and_return_nil
    item_repository = ItemRepository.new('./short_tests/short_items.csv')

    assert_equal [], item_repository.find_all_with_description("Something Fun!")
  end

  def test_it_can_find_all_by_price
    item_repository = ItemRepository.new('./short_tests/short_items.csv')

    item_1 = item_repository.find_by_id(5)
    item_2 = item_repository.find_by_id(3)

    assert_equal [], item_repository.find_all_by_price(0.00)
    assert_equal [item_2,item_1], item_repository.find_all_by_price(22.00)
  end

  def test_it_can_find_all_by_range
    item_repository = ItemRepository.new('./short_tests/short_items.csv')

    item_1 = item_repository.find_by_id(1)
    item_2 = item_repository.find_by_id(2)
    item_3 = item_repository.find_by_id(4)


    assert_equal [item_1,item_2,item_3], item_repository.find_all_by_price_in_range(5.00 .. 20.00)
  end

  def test_it_can_find_by_merchant_id
    item_repository = ItemRepository.new('./short_tests/short_items.csv')

    item_1 = item_repository.find_by_id(1)
    item_2 = item_repository.find_by_id(2)

    assert_equal [item_1,item_2], item_repository.find_all_by_merchant_id(2)

    assert_equal [], item_repository.find_all_by_merchant_id(12)
  end

  def test_it_can_update_attributes_and_time
    item_repository = ItemRepository.new('./short_tests/short_items.csv')

    attributes = {name: "My Favorite Store", description: "It's just the best store ever!", unit_price: 5000}
    item_repository.update(4, attributes)
    item_1 = item_repository.find_by_id(4)

    assert_equal 4, item_1.id
    assert_equal "My Favorite Store", item_1.name
    assert_equal "It's just the best store ever!", item_1.description
    refute "2016-01-11 12:29:33 UTC" == item_1.updated_at
  end

  def test_it_can_delete_merchants_by_id
    item_repository = ItemRepository.new('./short_tests/short_items.csv')
    item = item_repository.find_by_id(3)
    item_repository.delete(3)

    refute item_repository.repo.include?(item)
  end

end
