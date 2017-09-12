require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require 'pry'

class MerchantRepositoryTest < Minitest::Test

  attr_reader :mr

  def setup
    @mr = MerchantRepository.new('./data/merchants_test.csv')
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_merchant_list_returns_a_hash_of_ids_as_keys_and_names_as_values
    actual = @mr.merchant_list

    assert_instance_of Merchant, actual[0]
    assert_instance_of Merchant, actual[1]
    assert_equal 2, actual.length
  end

  def test_all_returns_array_of_all_known_merchant_instances
    skip
  end

end
