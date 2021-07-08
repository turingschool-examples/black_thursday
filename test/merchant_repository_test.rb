require_relative 'test_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < MiniTest::Test
  attr_reader :mr

  def setup
    @mr = MerchantRepository.new
  end

  def test_it_exists
    assert_instance_of MerchantRepository, mr
  end

  def test_repo_populated_with_merchant_objects
    mr.populate('test/fixtures/merchants_fixture.csv')

    assert_instance_of Array, mr.all
    assert_instance_of Merchant, mr.all.first
  end

  def test_can_retrieve_all_merchant_instances
    mr.populate('test/fixtures/merchants_fixture.csv')

    assert_equal 3, mr.all.length
  end

  def test_can_find_merchant_by_id
    mr.populate('./test/fixtures/merchants_fixture.csv')

    assert_instance_of Merchant, mr.find_by_id(12334112)
    assert_nil mr.find_by_id(52334141)
  end

  def test_can_find_merchant_by_name
    mr.populate('test/fixtures/merchants_fixture.csv')

    assert_instance_of Merchant, mr.find_by_name("MiniatureBikez&co")
    assert_nil mr.find_by_name("Hello World")
  end

  def test_can_find_all_merchants_which_contain_name_fragment
    mr.populate('test/fixtures/merchants_fixture.csv')

    assert_instance_of Array, mr.find_all_by_name("ol")
    assert_equal 3, mr.find_all_by_name("&co").count
    assert_equal [], mr.find_all_by_name("Hello WORLD")
  end

end
