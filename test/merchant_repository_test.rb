require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './lib/merchant'
require './lib/sales_engine'
require 'csv'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists_and_has_attributes
    mr = MerchantRepository.new("./data/merchants.csv")


  assert_instance_of MerchantRepository, mr
  assert_equal [], mr.merchants
  assert_equal "./data/merchants.csv", mr.path

  end

  def test_it_can_read_merchants
    

  end

end
