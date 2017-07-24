require_relative 'test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_that_merchant_repo_class_exist
    mr = MerchantRepository.new
    assert_instance_of MerchantRepository, mr
  end

  
end
