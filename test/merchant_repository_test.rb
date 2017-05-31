require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepoTest < Minitest::Test

  def test_class_exists
    result = MerchantRepository.new#(['a', 'b'])
    assert_instance_of MerchantRepository, result
  end

end
