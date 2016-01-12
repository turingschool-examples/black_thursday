require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_an_instance_of_item_repo_exists
    repo = ItemRepository.new
    assert repo.instance_of?(ItemRepository)
  end

  def test_item_repo_can_load_data

    repo = ItemRepository.new
    file = './data/test_items.csv'
    data = repo.load_data(file)
    repo.data_into_hash(data)

    assert_equal 5, repo.all_items.count
  end

  def test_find_by_id_defaults_nil
    repo = ItemRepository.new
    file = './data/test_items.csv'
    data = repo.load_data(file)
    repo.data_into_hash(data)

    assert_equal nil, repo.find_by_id("7")
  end

  def test_find_by_id_works
    repo = ItemRepository.new
    file = './data/test_items.csv'
    data = repo.load_data(file)
    repo.data_into_hash(data)

    assert repo.find_by_id("1")
  end

  def test_find_by_name_defaults_nil
    repo = ItemRepository.new
    file = './data/test_items.csv'
    data = repo.load_data(file)
    repo.data_into_hash(data)

    assert_equal nil, repo.find_by_name("test")
  end

  def test_find_by_name_works
    repo = ItemRepository.new
    file = './data/test_items.csv'
    data = repo.load_data(file)
    repo.data_into_hash(data)

    assert repo.find_by_name("Item Qui Esse")
  end

  def test_find_all_with_description_returns_empty_array
    repo = ItemRepository.new
    file = './data/test_items.csv'
    data = repo.load_data(file)
    repo.data_into_hash(data)

    assert_equal [], repo.find_all_with_description("asdf")
  end

  def test_find_all_with_description_returns_an_instance
    repo = ItemRepository.new
    file = './data/test_items.csv'
    data = repo.load_data(file)
    repo.data_into_hash(data)
    description = "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro."

    assert_equal 1, repo.find_all_with_description(description).count
  end

  def test_find_all_by_merchant_id_returns_an_empty_array
    repo = ItemRepository.new
    file = './data/test_items.csv'
    data = repo.load_data(file)
    repo.data_into_hash(data)
    assert_equal 5, repo.find_all_by_merchant_id("1").count
  end
end
