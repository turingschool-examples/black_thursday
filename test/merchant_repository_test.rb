require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
attr_reader :repo, :file, :data

  def setup
    @repo = MerchantRepository.new
    @file = './data/test_merchant.csv'
    @data = repo.load_data(file)
  end

  def test_an_instance_merchant_repo_exists
    assert repo.instance_of?(MerchantRepository)
  end

  def test_merchant_repo_can_load_data
    repo.data_into_hash(data)

    assert_equal 5, repo.all_merchants.count
  end

  def test_find_by_id_defaults_nil
    repo.data_into_hash(data)

    assert_equal nil, repo.find_by_id("4")
  end

  def test_find_by_id_works
    repo.data_into_hash(data)
    assert repo.find_by_id("2")
  end

  def test_find_by_name_defaults_nil
    repo.data_into_hash(data)

    assert_equal nil, repo.find_by_name("test")
  end

  def test_find_by_name_works
    repo.data_into_hash(data)

    assert repo.find_by_name("Schroeder-Jerde")
  end

  def test_find_all_by_name_defaults_nil
    repo.data_into_hash(data)

    assert_equal [], repo.find_all_by_name("Jimmy")
  end

  def test_find_by_all_name_works
    repo.data_into_hash(data)

    assert_equal 2, repo.find_all_by_name("Williamson Group").count
  end
end
