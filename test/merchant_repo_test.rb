require 'pry'
require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/csv_adaptor'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repo'

class MerchantRepoTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepo.new("./data/merchants.csv")

    assert_instance_of MerchantRepo, mr
  end

  def test_all_merchant_characteristics_returns_array_of_merchant_characteristics
    mr = MerchantRepo.new("./data/merchants.csv")

    assert_instance_of Array, mr.all_merchant_characteristics
  end

  def test_all_returns_array_of_merchant_objects
    mr = MerchantRepo.new("./data/merchants.csv")

    assert_instance_of Merchant, mr.all[1]
  end

  def test_find_by_id_returns_merchant_id
    mr = MerchantRepo.new("./data/merchants.csv")
    mr.all
    id = 12334115
    expected = mr.merchants[3]

    assert_equal expected, mr.find_by_id(id)
  end

  def test_find_by_name_returns_merchant_name
    mr = MerchantRepo.new("./data/merchants.csv")
    mr.all
    name = "LolaMarleys"
    expected = mr.merchants[3]

    assert_equal expected, mr.find_by_name(name)
  end

  # def test_it_returns_nil_when_name_or_id_dont_exist
  #   mr = MerchantRepo.new("./data/merchants.csv")
  #   mr.all
  #   name = "amy"
  #   # id = "12345"
  #
  #   assert_equal nil, mr.find_by_name(name)
  #   # assert_equal nil, mr.find_by_id(id)
  # end

end
