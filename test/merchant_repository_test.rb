require_relative "test_helper"

class MerchantRepositoryTest < MiniTest::Test

  def test_it_exists
    mr = MerchantRepository.new

    assert_instance_of MerchantRepository, mr
  end

  def test_repo_populated_with_merchant_objects
    mr = MerchantRepository.new
    mr.populate('data/merchants.csv')

    assert_instance_of Array, mr.all
    assert_instance_of Merchant, mr.all.first
  end

  def test_can_retrieve_all_merchant_instances
    mr = MerchantRepository.new
    mr.populate('data/merchants_fixture.csv')

    assert_equal 10, mr.all.length
  end

end
