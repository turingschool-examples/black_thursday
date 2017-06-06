require 'pry'
require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < MiniTest::Test

  def setup
    @file_path = './test/data/merchants_test.csv'
  end

  def test_if_create_class
    mr = MerchantRepository.new(@file_path)

    assert_instance_of MerchantRepository, mr
    assert_equal 5, mr.all.length
  end


  def test_if_find_by_id_returns_correct_value_for_method
    mr = MerchantRepository.new(@file_path)

    actual_1 = mr.find_by_id(12334105)
    actual_2 = mr.find_by_id(800)

    assert_equal mr.all[0], actual_1
    assert_nil actual_2
  end

  def test_if_find_by_name_works
    mr = MerchantRepository.new(@file_path)

    actual_1 = mr.find_by_name("Shopin1901")
    actual_2 = mr.find_by_name("Mike Dao's Torture Chamber")

    assert_equal mr.all[0], actual_1
    assert_nil actual_2
  end

  def test_if_find_all_by_name_works
    mr = MerchantRepository.new(@file_path)

    actual_1 = mr.find_all_by_name("Shopin19")
    actual_2 = mr.find_all_by_name("Mike Dao's Torture Chamber")

    assert_equal [mr.all[0], mr.all[2]], actual_1
    assert_equal [], actual_2
  end

end
