require './test/test_helper'
require './lib/merchant_repository'
require 'pry'

class MerchantRepositoryTest < Minitest::Test
  def test_merchant_repository_exists
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    assert_instance_of MerchantRepository, mr
  end

  def test_returns_all_instances
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    refute mr.merchants.empty?, mr.merchants
    assert_equal 6, mr.all.count
    assert_equal 'HeadyMamaCreations', mr.all[0].name
  end

  def test_find_by_id
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    assert_nil mr.find_by_id(7834)
    assert_instance_of Merchant, mr.find_by_id(1)
  end

  def test_find_by_name
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    assert_nil mr.find_by_name("Buffalo Bill")
    assert_instance_of Merchant, mr.find_by_name('HeadyMamaCreations')
    assert_instance_of Merchant, mr.find_by_name('headyMAMACreations')
  end

  def test_find_all_by_name
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    assert_equal [], mr.find_all_by_name("Buffalo Bill")
    assert_equal ['HeadyMamaCreations'], mr.find_all_by_name('headyMamacreations')
    assert_equal ['CJsDecor', 'CJsDecorTEST'], mr.find_all_by_name('cj')
  end

  def test_find_highest_id
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    assert_equal 6, mr.find_highest_id
  end


  def test_create_new_id
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    assert_equal 7, mr.create_new_id
  end

  def test_create
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    mr.create ()
    assert_equal 7, mr.all[6].id
    assert_equal "Turing School", mr.all[6].name
  end
end
