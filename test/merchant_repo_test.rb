require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new('./data/merchants_tiny.csv', self)
    assert_instance_of MerchantRepository, mr
  end

  def test_it_loads_merchants
    mr = MerchantRepository.new('./data/merchants_tiny.csv', self)
    actual = mr.collection.count
    expected = 9
    assert_equal expected, actual
  end

  def test_all
    mr = MerchantRepository.new('./data/merchants_tiny.csv', self)
    actual = mr.all.count
    expected = 9
    assert_equal expected, actual
  end

  def test_find_by_id
    mr = MerchantRepository.new('./data/merchants_tiny.csv', self)
    actual = mr.find_by_id(12334123)[:id]
    expected = 12334123
    assert_equal expected, actual
  end

  def test_find_by_name
    mr = MerchantRepository.new('./data/merchants_tiny.csv', self)
    actual = mr.find_by_name("Keckenbauer")[:name]
    expected = "Keckenbauer"
    assert_equal expected, actual
  end

  def test_find_all_by_name
    mr = MerchantRepository.new('./data/merchants_tiny.csv', self)
    actual = mr.find_all_by_name("bauer")[0][:name]
    expected = "Keckenbauer"
    assert_equal expected, actual
  end

  def test_delete
    mr = MerchantRepository.new('./data/merchants_tiny.csv', self)
    assert_equal 9, mr.collection.length
    mr.delete(12334123)
    actual = mr.collection.length
    expected = 8
    assert_equal expected, actual
  end

  def test_create
    mr = MerchantRepository.new('./data/merchants_tiny.csv', self)
    mr.create({:id => 0, :name=>"Melvin", :created_at=>"2018-09-08", :updated_at=>"2018-09-08"})
    newdude = mr.collection.max_by {|element| element[:id]}
    actual = newdude[:id]
    expected = 12334145
    assert_equal expected, actual
  end

  def test_update
    mr = MerchantRepository.new('./data/merchants_tiny.csv', self)
    mr.update(12334123, [[:name , "Keckenbooty"]])
    updated_item = mr.find_by_id(12334123)
    assert_equal "Keckenbooty", updated_item[:name]
  end

end
