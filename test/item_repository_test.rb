require 'simplecov'
SimpleCov.start
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def setup
    @item_repository = ItemRepository.new
    @item_repository.create_with_id({id: 1,
                                     name: "Pencil",
                                     description: "Pointy",
                                     unit_price: "100",
                                     created_at: "2017-01-01 00:00:00",
                                     updated_at: "2017-01-01 00:00:00",
                                     merchant_id: 1
                                    })
    @item_repository.create_with_id({id: 2,
                                     name: "Book",
                                     description: "Wordy",
                                     unit_price: "1000",
                                     created_at: "2017-01-01 00:00:00",
                                     updated_at: "2017-01-01 00:00:00",
                                     merchant_id: 2
                                    })
    @item_repository.create_with_id({id: 3,
                                     name: "Laptop",
                                     description: "Expensive",
                                     unit_price: "10000",
                                     created_at: "2017-01-01 00:00:00",
                                     updated_at: "2017-01-01 00:00:00",
                                     merchant_id: 3
                                    })
    @item_repository.create_with_id({id: 4,
                                     name: "Car",
                                     description: "expensive luxury",
                                     unit_price: "1000000",
                                     created_at: "2017-01-01 00:00:00",
                                     updated_at: "2017-01-01 00:00:00",
                                     merchant_id: 3
                                    })
  end

  def test_it_exists
    ir = ItemRepository.new
    assert_instance_of ItemRepository, ir
  end

  def test_it_starts_with_no_items
    ir = ItemRepository.new
    assert_equal [], ir.all
  end

  def test_we_can_find_an_item_by_id
    id = 1
    result = @item_repository.find_by_id(1).id
    assert_equal id, result
  end

  def test_we_can_find_item_by_name
    name = "Pencil"
    result = @item_repository.find_by_name(name).name
    assert_equal name, result
  end

  def test_we_can_find_all_merchants_by_description
    item_1 = @item_repository.find_by_id(3)
    item_2 = @item_repository.find_by_id(4)
    expected = [item_1, item_2]
    result = @item_repository.find_all_with_description("expensive")

    assert_equal expected, result
  end

  def test_we_can_find_all_by_price
    item_1 = @item_repository.find_by_id(3)

    expected = [item_1]
    result = @item_repository.find_all_by_price(100)
    assert_equal expected, result
  end

  def test_we_can_find_all_by_price_in_range
    item_1 = @item_repository.find_by_id(1)
    item_2 = @item_repository.find_by_id(2)
    expected = [item_1,item_2]
    result = @item_repository.find_all_by_price_in_range((1..10))
    assert_equal expected, result
  end

  def test_we_can_find_all_by_merchant_id
    item_1 = @item_repository.find_by_id(3)
    item_2 = @item_repository.find_by_id(4)
    expected = [item_1, item_2]
    result = @item_repository.find_all_by_merchant_id(3)
    assert_equal expected, result
  end

  def test_we_can_create_an_item_instance_with_incremented_id
    item = @item_repository.create({name: "Patrick",
                                              description: "Male",
                                              unit_price: "100",
                                              created_at: "2017-01-01 00:00:00",
                                              updated_at: "2017-01-01 00:00:00",
                                              merchant_id: 5
                                            })
    expected = 5
    assert_equal expected, @item_repository.all[4].id
  end

  def test_we_can_update_item_attributes
    item = @item_repository.find_by_id(1)

    @item_repository.update(1, {unit_price: 1})
    expected = 1
    assert_equal expected, item.unit_price_to_dollars
  end

  def test_we_can_delete
    @item_repository.delete(1)
    item = @item_repository.find_by_id(1)
    assert_nil item
  end

end
