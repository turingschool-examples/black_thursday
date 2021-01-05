require_relative 'minitest/autorun'
require_relative 'minitest/pride'
require_relative './lib/merchant_repo'

class MerchantRepositoryTest < MiniTest::Test

  def test_it_exists
    mr = MerchantRepository.new

    assert_instance_of MerchantRepository, mr
  end
end
