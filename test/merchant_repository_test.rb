require 'CSV'
require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @engine = mock
    @dummy_path = './dummy_data/dummy_merchants.csv'
    @merchant_repo = MerchantRepository.new(@dummy_path, @engine)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repo
  end

  def test_it_has_attributes
    assert_equal @dummy_path, @merchant_repo.data
    assert_instance_of Hash, @merchant_repo.merchant_info
  end

  def test_populate_repo
    assert_equal 5, @merchant_repo.merchant_info.count
  end

  def test_all
    assert_equal 5, @merchant_repo.all.count
  end

  def test_find_by_id
    assert_equal 'jejum', @merchant_repo.find_by_id(12334141)[1].name
    assert_nil @merchant_repo.find_by_id(12)
  end

  def test_find_by_name
    assert_equal '12334141', @merchant_repo.find_by_name('jejum')[1].id
    assert_nil @merchant_repo.find_by_name('Caryn')
  end

  def test_find_all_by_name
    assert_equal 2, @merchant_repo.find_all_by_name("en").count
    assert_equal [], @merchant_repo.find_all_by_name("Burt Reynolds")
  end

  def test_max_id
    assert_equal "12334141", @merchant_repo.max_id[0]
  end

  def test_new_id
    assert_equal 12334142, @merchant_repo.new_id
  end

  def test_create
    data = {:name => 'Hank', :id => "12334143", :created_at => "2008-06-09", :updated_at => "2008-06-09"}
    actual = @merchant_repo.create('Hank')
    assert_equal @merchant_repo.max_id[0].to_i + 1, @merchant_repo.new_id
    assert_equal 'Hank', @merchant_repo.merchant_info.values.last.name
  end

  def test_update
    @merchant_repo.update("12334115", "New Name")
    assert_equal "12334115", @merchant_repo.merchant_info["12334115"].id
    assert_equal "New Name", @merchant_repo.merchant_info["12334115"].name
  end

  def test_delete
    @merchant_repo.delete("12334115")
    assert_equal false, @merchant_repo.merchant_info.has_key?("12334115")
  end

end
