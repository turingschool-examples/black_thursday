require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
attr_reader :repo, :merchant_file, :data, :item_file

  def setup
    @merchant_file = './data/test_merchant.csv'
    @item_file = './data/test_items.csv'
    @repo = MerchantRepository.new(merchant_file, item_file)
  end

  def test_an_instance_merchant_repo_exists
    assert repo.instance_of?(MerchantRepository)
  end

  def test_merchant_repo_can_load_data
    assert_equal 5, repo.all_merchants.count
  end

  def test_find_by_id_defaults_nil
  assert_equal nil, repo.find_by_id("4")
  end

  def test_find_by_id_works
  assert repo.find_by_id("2")
  end

  def test_find_by_name_defaults_nil
    assert_equal nil, repo.find_by_name("test")
  end

  def test_find_by_name_works
    assert repo.find_by_name("Schroeder-Jerde")
  end

  def test_find_all_by_name_defaults_nil
    assert_equal [], repo.find_all_by_name("Jimmy")
  end

  def test_find_by_all_name_works
    assert_equal 2, repo.find_all_by_name("Williamson Group").count
  end
end
