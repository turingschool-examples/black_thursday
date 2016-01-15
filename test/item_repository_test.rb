require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
attr_reader :item_repo

  def setup
    item_file = './data/test_items.csv'
    @item_repo = ItemRepository.new(item_file)
  end

  def test_an_instance_of_item_repo_exists
    assert item_repo.instance_of?(ItemRepository)
  end

  def test_item_repo_all_method_always_returns_instance_of_item
    expected = item_repo.all
    expected.each do |item|
      assert_equal Item, item.class
    end
  end

  def test_item_repo_can_load_data
    assert_equal 5, item_repo.all.count
  end

  def test_find_by_id_defaults_nil
    assert_equal nil, item_repo.find_by_id(7)
  end

  def test_find_by_id_works
    assert item_repo.find_by_id(1)
  end

  def test_find_by_name_defaults_nil
    assert_equal nil, item_repo.find_by_name("test")
  end

  def test_find_by_name_works

    assert item_repo.find_by_name("Item Qui Esse")
  end

  def test_find_all_with_description_returns_empty_array

    assert_equal [], item_repo.find_all_with_description("asdf")
  end

  def test_find_all_with_description_returns_an_instance
    description = "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro."

    assert_equal 1, item_repo.find_all_with_description(description).count
  end

  def test_find_all_by_price_defaults_to_empty_array
    assert_equal [], item_repo.find_all_by_price(243534)
  end

  def test_find_all_by_price_returns_array_of_items
    assert_equal 1, item_repo.find_all_by_price(75107).count
  end

  def test_find_all_by_price_in_range_defaults_empty_array
    assert_equal [], item_repo.find_all_by_price_in_range(7567800..752897897)
  end

  def test_find_all_by_price_in_range_returns_array_of_items
    assert_equal 5, item_repo.find_all_by_price_in_range(1..100000).count
  end

  def test_find_all_by_merchant_id_returns_an_empty_array
    assert_equal [], item_repo.find_all_by_merchant_id(65)
  end
end
