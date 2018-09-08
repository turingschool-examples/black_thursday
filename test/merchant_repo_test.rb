require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    assert_instance_of MerchantRepository, mr
  end

  def test_it_loads_merchants
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.collection.length
    expected = 9
    assert_equal expected, actual
  end

  def test_crud_all
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.all.length
    expected = 9
    assert_equal expected, actual
  end

  def test_crud_find_by_id
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.find_by_id(12334123)
    expected = {:id=>12334123, :name=>"Keckenbauer", :created_at=>"2010-07-15", :updated_at=>"2012-07-25"}
    assert_equal expected, actual
  end

  def test_crud_find_by_name
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.find_by_name("Keckenbauer")
    expected = {:id=>12334123, :name=>"Keckenbauer", :created_at=>"2010-07-15", :updated_at=>"2012-07-25"}
    assert_equal expected, actual
  end

  def test_crud_find_by_name
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.find_all_by_name("bauer")
    expected = [{:id=>12334123, :name=>"Keckenbauer", :created_at=>"2010-07-15", :updated_at=>"2012-07-25"}]
    assert_equal expected, actual
  end

end
