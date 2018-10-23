require './test/test_helper'

class MerchantRepository < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new
    assert_instance_of MerchantRepository, mr
  end

end
