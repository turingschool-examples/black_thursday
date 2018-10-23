require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @mr = MerchantRepository.new
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_create_adds_merchant
    @mr.create("Mr. Merchant")
    assert_equal 1, @mr.all.size
    assert_equal 1, @mr.all[0].id
    assert_equal "Mr. Merchant", @mr.all[0].name
  end

end
