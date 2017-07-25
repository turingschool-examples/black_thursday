require './lib/merchant_repository'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class MerchantRepositoryTest < Minitest::Test
  def test_it_can_be_initialized
    mr = MerchantRepository.new
    assert mr
    assert_instance_of MerchantRepository, mr
  end

  def test_data_can_be_added
    mr = MerchantRepository.new
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

end
