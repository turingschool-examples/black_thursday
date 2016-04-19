require './test/test_helper'
require './lib/merchant_repository'
# require './lib/sales_engine'



class MerchantRepositoryTest < Minitest::Test

  def test_setup
    assert MerchantRepository.new.class
  end
end
