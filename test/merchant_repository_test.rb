require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
attr_reader :merchant_repo

  def setup
    merch_file = './data/test_merchant.csv'
    @merchant_repo = MerchantRepository.new(merch_file)
  end

  def test_an_instance_merchant_repo_exists
    assert merchant_repo.instance_of?(MerchantRepository)
  end

  def test_merch_repo_all_method_always_returns_instance_of_invoice
    expected = merchant_repo.all
    expected.each do |merchant|
      assert_equal Merchant, merchant.class
    end
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
end
