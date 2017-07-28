require 'simplecov'
SimpleCov.start
require_relative '../lib/merchant_repository'
require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'

class MerchantRepositoryTest < Minitest::Test

  def setup
    # @merchant_r = MerchantRepository.new(self)
    hash_one   = {id:1, name: "Target"}
    hash_two   = {id:2, name: "Walmart"}
    hash_three = {id:3, name: "CostMart"}
    hash_four  = {id:4, name: "Costco"}
    @merchant_r = MerchantRepository.new(self)
    @merchant_r.add_data(hash_one)
    @merchant_r.add_data(hash_two)
    @merchant_r.add_data(hash_three)
    @merchant_r.add_data(hash_four)
  end


  def test_it_can_be_initialized
    mr = MerchantRepository.new(self)
    assert mr
    assert_instance_of MerchantRepository, mr
    assert mr.merchants.empty?
  end

  def test_data_can_be_added
    mr = MerchantRepository.new(self)
    hash_one = {
    id: 12334113, name: "MiniatureBikez"}
    hash_two = {
    id: 12334115, name: "LolaMarleys"   }
    mr.add_data(hash_one)
    mr.add_data(hash_two)
    assert_equal 2, mr.merchants.count
    assert_equal 12334113, mr.merchants.first.id
    assert_equal 12334115, mr.merchants.last.id
    assert_equal "MiniatureBikez", mr.merchants.first.name
    assert_equal "LolaMarleys", mr.merchants.last.name
  end

  def test_all_is_working
    list = @merchant_r.merchants
    assert_equal 4, list.count
    assert_equal 1, list.first.id
    assert_equal 4, list.last.id
  end

  def test_find_by_id_is_working
    found = @merchant_r.find_by_id(3)
    assert_equal 3, found.id
    assert_equal "CostMart", found.name
  end

  def test_find_by_name_is_working
    found = @merchant_r.find_by_name("Walmart")
    assert_equal 2, found.id
    assert_equal "Walmart", found.name
  end

  def test_find_all_by_name_is_working_for_one_entry
    list = @merchant_r.find_all_by_name("Walmart")
    assert_equal 1, list.count
    assert_equal 2, list.first.id
  end

  def test_find_all_is_working_for_just_part_of_the_name
    list = @merchant_r.find_all_by_name("lma")
    assert_equal 1, list.count
    assert_equal 2, list.first.id
  end

  def test_find_all_by_name_is_working_for_multiple_entries
    list = @merchant_r.find_all_by_name("mart")
    assert_equal 2, list.count
    assert_equal 2, list.first.id
    assert_equal 3, list.last.id
    list_two = @merchant_r.find_all_by_name("t")
    assert_equal 4, list_two.count
  end

end
