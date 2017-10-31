require './test/test_helper'
require 'pry'

class MerchantRepositoryTest < MiniTest::Test

  def setup
    @merchant_repository = MerchantRepository.new(nil)
  end

  def test_that_merchants_are_created
    assert_equal 0, @merchant_repository.count
    @merchant_repository.create_merchant(:name => "Ali's Alliterations")


  end


end
