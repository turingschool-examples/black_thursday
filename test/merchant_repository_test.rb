require './test/test_helper'
require './lib/sales_engine'
require '.lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test

  def test_setup
    assert MerchantRepository.new.class
  end
end
