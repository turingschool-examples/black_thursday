require_relative '../lib/item_repository'
require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'time'
require 'pry'

class ItemRepositoryTest < Minitest::Test

  def setup
    @repo = ItemRepository.new(self)
  end


  def test_it_is_initialized
    assert @repo
    assert_instance_of ItemRepository, @repo
  end

  def test_it_can_be_added_to
    full_repo
    assert_equal 111, @repo.items[0].id
    assert_equal 222, @repo.items[1].id
    assert_equal "Candy", @repo.items[0].name
    assert_equal "Hat", @repo.items[1].name
  end

  def test_all_is_working
    @repo.add_data(item_one)
    @repo.add_data(item_two)
    assert_equal 2, @repo.items.count
    @repo.add_data(item_three)
    assert_equal 3, @repo.items.count
    assert_equal 11, @repo.items[0].merchant_id
    assert_equal "Candy", @repo.items[0].name
    assert_equal 20.0, @repo.items[-1].dollars
  end

  def test_find_by_id_working
    full_repo
    item = @repo.find_by_id(222)
    assert_instance_of Item, item
    assert_equal 12, item.merchant_id
    assert_equal "Hat", item.name
  end

  def test_find_by_name_working
    full_repo
    item = @repo.find_by_name("Pants")
    assert_instance_of Item, item
    assert_equal 13, item.merchant_id
    assert_equal "mint", item.description
    assert_equal "Pants", item.name
  end

  def test_find_all_with_description_working_for_one_entry
    full_repo
    item = @repo.find_all_with_description("mint")
    assert_equal 1, item.count
    assert_equal "Pants", item[0].name
    assert_equal 13, item[0].merchant_id
  end

  def test_find_all_with_description_working_for_multiple_entries
    full_repo
    items = @repo.find_all_with_description("blue")
    assert_equal 2, items.count
    assert_equal "Hat", items[0].name
    assert_equal "Shirt", items[-1].name
  end

  def test_all_by_price_works_for_one_entry
    full_repo
    item = @repo.find_all_by_price(1000 / 100)
    assert_equal 1, item.count
    assert_equal "Hat", item[0].name
    assert_equal 12, item.first.merchant_id
  end

  def test_all_by_price_works_for_multiple_entries
    full_repo
    list = @repo.find_all_by_price(2000 / 100)
    assert_equal 2, list.count
    assert_equal "Pants", list[0].name
    assert_equal "Shirt", list[-1].name
    assert_equal 13, list[0].merchant_id
    assert_equal 11, list[-1].merchant_id
  end

  def test_all_by_price_in_range_works_for_one_entry
    full_repo
    item = @repo.find_all_by_price_in_range(1..2)
    assert_equal 1, item.count
    assert_equal "Candy", item[0].name
    assert_equal 1.2, item[0].dollars
  end

  def test_all_by_price_in_range_works_for_multiple_entries
    full_repo
    items = @repo.find_all_by_price_in_range(9..21)
    assert_equal 3, items.count
    assert_equal "Hat", items[0].name
    assert_equal 20.0, items[-1].dollars
  end

  def test_find_all_by_merchant_id_works_for_one_entry
    full_repo
    list = @repo.find_all_by_merchant_id(12)
    assert_equal 1, list.count
    assert_equal "Hat", list[0].name
  end

  def test_find_all_by_merchant_id_works_for_multiple_entries
    full_repo
    list = @repo.find_all_by_merchant_id(11)
    assert_equal 2, list.count
    assert_equal "Candy", list[0].name
    assert_equal "Shirt", list[-1].name
  end

  def item_one
    {id: 111,
    name: "Candy",
    description: "yellow",
    unit_price: 120,
    merchant_id: 11,
    created_at: "2016-01-11 11:51:31 UTC",
    updated_at: "2016-01-11 11:51:31 UTC"
    }
  end

  def item_two
    {id: 222,
    name: "Hat",
    description: "blue",
    unit_price: 1000,
    merchant_id: 12,
    created_at: "2016-02-11 11:51:32 UTC",
    updated_at: "2016-02-11 11:51:32 UTC"
    }
  end

  def item_three
    {id: 333,
    name: "Pants",
    description: "mint",
    unit_price: 2000,
    merchant_id: 13,
    created_at: "2016-03-11 11:51:33 UTC",
    updated_at: "2016-03-11 11:51:33 UTC"
    }
  end

  def item_four
    {id: 444,
    name: "Shirt",
    description: "blue",
    unit_price: 2000,
    merchant_id: 11,
    created_at: "2016-04-11 11:51:34 UTC",
    updated_at: "2016-04-11 11:51:34 UTC"
    }
  end

  def full_repo
    @repo.add_data(item_one)
    @repo.add_data(item_two)
    @repo.add_data(item_three)
    @repo.add_data(item_four)
  end

end
