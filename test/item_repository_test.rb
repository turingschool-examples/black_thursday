require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/merchant_repository'

class ItemRepositoryTest < Minitest::Test
attr_reader :item_repo, :item_file, :merch_file, :data, :se

  def setup
    @item_file = './data/test_items.csv'
    @merch_file = './data/test_merchant.csv'
    @se = SalesEngine.from_csv({
          :items     => item_file,
          :merchants => merch_file,
          })
    @item_repo = se.items
  end

  def test_an_instance_of_item_repo_exists
    assert item_repo.instance_of?(ItemRepository)
  end

  def test_item_repo_can_load_data
    assert_equal 5, item_repo.all.count
  end

  def test_find_by_id_defaults_nil
    assert_equal nil, item_repo.find_by_id("7")
  end

  def test_find_by_id_works
    assert item_repo.find_by_id("1")
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

  def test_find_all_by_merchant_id_returns_an_empty_array
    assert_equal [], item_repo.find_all_by_merchant_id("65")
  end

  def test_item_can_find_its_merchant
    item = item_repo.find_by_name("Item Qui Esse")

    assert item.merchant
  end

end
