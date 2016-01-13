require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
attr_reader :merchant_repo, :merch_file, :item_file, :data, :item_file, :se

  def setup
    @item_file = './data/test_items.csv'
    @merch_file = './data/test_merchant.csv'
    @se = SalesEngine.from_csv({
          :items     => item_file,
          :merchants => merch_file,
          })
    @merchant_repo = se.merchants
  end

  def test_an_instance_merchant_repo_exists
    assert merchant_repo.instance_of?(MerchantRepository)
  end

  def test_merchant_repo_can_load_data
    assert_equal 5, merchant_repo.all.count
  end

  def test_find_by_id_defaults_nil
  assert_equal nil, merchant_repo.find_by_id(4)
  end

  def test_find_by_id_works
  assert merchant_repo.find_by_id(2)
  end

  def test_find_by_name_defaults_nil
    assert_equal nil, merchant_repo.find_by_name("test")
  end

  def test_find_by_name_works
    assert merchant_repo.find_by_name("Schroeder-Jerde")
  end

  def test_find_all_by_name_defaults_nil
    assert_equal [], merchant_repo.find_all_by_name("Jimmy")
  end

  def test_find_by_all_name_works
    assert_equal 2, merchant_repo.find_all_by_name("Williamson Group").count
  end

  def test_an_instance_of_item_repo_exists

    assert se.items.instance_of?(ItemRepository)
  end

  def test_items_can_be_accessed_by_merchant
    merchant = se.items
    items = merchant.find_all_by_merchant_id(1)
    assert_equal 2, items.count
  end

  def test_merchant_with_no_items_returns_empty_array
    merchant = se.items
    items = merchant.find_all_by_merchant_id("6")
    assert_equal [], items
  end
end
