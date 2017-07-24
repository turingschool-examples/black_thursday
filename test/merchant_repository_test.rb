require './lib/merchant_repository'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @mr = MerchantRepository.new
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_can_return_array_of_known_merchant_instances
    assert_equal [], @mr.all
  end
end
