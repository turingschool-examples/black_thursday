require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/merchant_repository'

class ItemRepositoryTest < Minitest::Test
attr_reader :repo, :item_file, :merch_file, :data, :se

  def setup
    @item_file = './data/test_items.csv'
    @merch_file = './data/test_merchant.csv'
    @se = SalesEngine.from_csv({
          :items     => item_file,
          :merchants => merch_file,
          })
    @repo = se.items
  end

  def test_an_instance_of_item_repo_exists
    assert repo.instance_of?(ItemRepository)
  end

  def test_item_repo_can_load_data

    assert_equal 5, repo.all_items.count
  end

  def test_find_by_id_defaults_nil

    assert_equal nil, repo.find_by_id("7")
  end

  def test_find_by_id_works

    assert repo.find_by_id("1")
  end

  def test_find_by_name_defaults_nil

    assert_equal nil, repo.find_by_name("test")
  end

  def test_find_by_name_works

    assert repo.find_by_name("Item Qui Esse")
  end

  def test_find_all_with_description_returns_empty_array

    assert_equal [], repo.find_all_with_description("asdf")
  end

  def test_find_all_with_description_returns_an_instance
    description = "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro."

    assert_equal 1, repo.find_all_with_description(description).count
  end

  def test_find_all_by_merchant_id_returns_an_empty_array
    assert_equal 2, repo.find_all_by_merchant_id("1").count
  end

end
