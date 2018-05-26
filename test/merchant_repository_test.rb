require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository.rb'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new("array")
    assert_instance_of MerchantRepository, mr
  end

  def test_it_makes_array_of_merchants
    mr = MerchantRepository.new("tom", "bill", "angela")
    assert_equal ["tom", "bill", "angela"], mr.repository
  end

end
