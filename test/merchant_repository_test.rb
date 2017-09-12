require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

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
    expected = { 12334105 => "Shopin1901", 12334112 => "Candisart" }

    assert_equal expected, actual
  end

  def test_all_returns_array_of_all_known_merchant_instances
    skip
  end

end
