require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @dummy_path = './dummy_data/dummy_merchants.csv'
  end

  def test_it_exists
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_instance_of MerchantRepository, merchant_repo
  end

  def test_it_has_attributes
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_equal 5, merchant_repo.all.count
    assert_equal @dummy_path, merchant_repo.data
  end

  def test_populate_repo
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_instance_of 5, merchant_repo.all.count
  end

  def test_all
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_equal 5, merchant_repo.all.count
  end

  def test_max_id
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_equal "12334141", merchant_repo.max_id[0]
  end

  def test_new_id
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_equal 12334142, merchant_repo.new_id
  end

  def test_create
    merchant_repo = MerchantRepository.new(@dummy_path)
    actual = merchant_repo.create('Hank')
    assert_equal merchant_repo.max_id[0].to_i + 1, merchant_repo.new_id
    assert_equal 'Hank', merchant_repo.all.values.last.name
  end

  def test_find_by_id
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_equal 'jejum', merchant_repo.find_by_id(12334141)[1].name
    assert_equal nil, merchant_repo.find_by_id(12)
  end

  def test_find_by_name
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_equal '12334141', merchant_repo.find_by_name('jejum')[1].id
    assert_equal nil, merchant_repo.find_by_name('Caryn')
  end

end
