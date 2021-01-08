require 'CSV'
require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @engine = mock
    @dummy_repo = MerchantRepository.new('./dummy_data/dummy_merchants.csv', @engine)
  end

  def test_it_exists

    assert_instance_of MerchantRepository, @dummy_repo
  end

  def test_it_has_attributes
    assert_instance_of Hash , @dummy_repo.collections
  end
  
  def test_populate_repo
    assert_equal 5, @dummy_repo.collections.count
  end

  def test_all
    assert_equal 5, @dummy_repo.all.count
  end

  def test_find_by_id
    assert_instance_of Merchant, @dummy_repo.find_by_id("12334141")
    assert_nil nil, @dummy_repo.find_by_id("12")
  end

  def test_find_by_name
    assert_equal '12334141', @dummy_repo.find_by_name('jejum').id
    assert_nil @dummy_repo.find_by_name('Caryn')
  end

  def test_find_all_by_name
    assert_equal 2, @dummy_repo.find_all_by_name("en").count
    assert_equal [], @dummy_repo.find_all_by_name("Burt Reynolds")
  end

  def test_max_id
    assert_equal 12334141, @dummy_repo.max_id
  end
  
  def test_new_id
    assert_equal 12334142, @dummy_repo.new_id
  end
  
  def test_it_can_create
    data ={
      :id => "910",
      :name => "chipotle",
      :created_at => "2125-09-22 09:34:06 UTC",
      :updated_at => "2034-09-04 21:35:10 UTC"
    }

    @dummy_repo.create(data)
    actual = @dummy_repo.collections.values[-1].id
    expected = @dummy_repo.max_id 
    assert_equal "12334142", actual
  
    assert_equal expected + 1, actual.to_i+1
  end


end
