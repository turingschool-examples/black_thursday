require_relative 'test_helper.rb'
require_relative '../lib/merchant_repository.rb'
require_relative '../lib/merchant.rb'

class MerchantRepositoryTest < Minitest::Test 
  attr_accessor :merch

  def setup 
    @merch = MerchantRepository.new('data/merchants.csv')
  end
  
  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, merch
  end

  def test_returns_array_all_merchant_instances 
    assert_equal 475, merch.all.length
  end

  def test_find_by_id_returns_merchant_with_id
    expected = merch.find_by_id(12336801)

    assert_equal '12336801', expected.id
    assert_instance_of Merchant, expected
  end

  def test_find_by_id_returns_nil_if_no_match    
    expected = merch.find_by_id(309482309482390482309)

    assert_nil expected
  end

  def test_find_by_name_returns_instance_of_merchant  
    expected = merch.find_by_name('PackingMonkey')

    assert_equal 'PackingMonkey', expected.name
    assert_instance_of Merchant, expected    
  end

  def test_find_by_name_returns_nil_if_no_match    
    expected = merch.find_by_name('coolGuyMcgee')

    assert_nil expected
  end

  def test_find_all_by_name_returns_array_of_merchants
    one    = merch.find_all_by_name('PackingMonkey')
    twenty = merch.find_all_by_name('design')

    assert_equal 1, one.length
    assert_equal 20, twenty.length
  end

  def test_find_all_by_name_returns_nil
    expected = merch.find_all_by_name('DonkeyKong')

    assert_equal [], expected
  end

end
