require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    skip
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    assert_instance_of MerchantRepository, mr
  end

  def test_it_loads_merchants
    skip
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.collection.length
    expected = 9
    assert_equal expected, actual
  end

  def test_all
    skip
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.all.length
    expected = 9
    assert_equal expected, actual
  end

  def test_find_by_id
    skip
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.find_by_id(12334123)
    expected = {:id=>12334123, :name=>"Keckenbauer", :created_at=>"2010-07-15", :updated_at=>"2012-07-25"}
    assert_equal expected, actual
  end

  def test_find_by_name
    skip
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.find_by_name("Keckenbauer")
    expected = {:id=>12334123, :name=>"Keckenbauer", :created_at=>"2010-07-15", :updated_at=>"2012-07-25"}
    assert_equal expected, actual
  end

  def test_find_all_by_name
    skip
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.find_all_by_name("bauer")
    expected = [{:id=>12334123, :name=>"Keckenbauer", :created_at=>"2010-07-15", :updated_at=>"2012-07-25"}]
    assert_equal expected, actual
  end

  def test_delete
    skip
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    assert_equal 9, mr.collection.length
    mr.delete(12334123)
    actual = mr.collection.length
    expected = 8
    assert_equal expected, actual
  end

  def test_create
    skip
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    mr.create({:id => 0, :name=>"Melvin", :created_at=>"2018-09-08", :updated_at=>"2018-09-08"})
    actual = mr.collection.max_by {|element| element[:id]}[:id]
    expected = 12334145
    assert_equal expected, actual
  end

  def test_update
    skip

    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    mr.update(12334123, [[:name , "Keckenbooty"]])
    updated_item = mr.find_by_id(12334123)
    assert_equal "Keckenbooty", updated_item[:name]
  end
  
  def test_it_create_instance_array
    skip
  
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual  = mr.create_instance(mr.collection)
    binding.pry
    expected = []
    assert_equal expected, actual
   end

   def test_it_gives_us_array_of_instance_hashes
    
    mr = MerchantRepository.new('./data/merchants_tiny.csv', self)
    actual = mr.merchants
    expected = []

    assert_equal expected, actual
   end


   def test_it_can_convert

    mr = MerchantRepository.new('./data/merchants_tiny.csv', self)
    mr.convert('./data/merchants_tiny.csv')
    assert_equal 15, mr.merchants.count
   end
end
