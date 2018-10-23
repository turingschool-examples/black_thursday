require './test/test_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @mr = MerchantRepository.new
    @merchant1 = Merchant.new({:id => 1, :name => "Mr. Merchant"})
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_create_adds_merchant
    @mr.create("Mr. Merchant")
    assert_equal [@merchant1], @mr.all
  end

end
