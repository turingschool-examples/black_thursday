require "./test/test_helper"
require "./lib/merchant_repository"
require "./lib/merchant"


class MerchantRepositoryTest < Minitest::Test

  attr_reader :mr

  def setup
    @mr = MerchantRepository.new
  end

  def test_it_exists
    assert_instance_of MerchantRepository, mr
  end

  def test_all_returns_array_of_merchants
    assert_equal [array of merchants], mr.all
  end

end
