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

  def test_can_find_merchant_by_id
    mr = MerchantRepository.new
    mr.populate('data/merchants_fixture.csv')

    assert_instance_of Merchant, mr.find_by_id(12334141)
    assert_nil mr.find_by_id(52334141)
  end

  def test_can_find_merchant_by_name
  end

  def test_can_find_all_merchants_which_contain_name_fragment
  end

end
