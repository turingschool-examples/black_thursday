require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < MiniTest::Test
  def test_all_returns_an_array_of_merchant_instances
    mr = MerchantRepository.new('./data/merchants.csv')

    result = mr.all

    assert result.all? do |element|
      element.class == Merchant
    end
  end

  def test_find_by_id_returns_nil_if_merchant_does_not_exist
    mr = MerchantRepository.new('./data/merchants.csv')

    assert nil, mr.find_by_id(789)
  end

  def test_find_by_id_returns_merchant_instance_with_matching_id
    mr = MerchantRepository.new('./data/merchants.csv')

    result = mr.find_by_id(568)

    assert_equal 568, result.id
    assert_instance_of Merchant, result
  end

  def test_find_by_name_returns_nil_if_merchant_does_not_exist
    mr = MerchantRepository.new('./data/merchants.csv')

    assert nil, mr.find_by_name('bill robbins')
  end

  def test_find_by_name_returns_merchant_instance_with_matching_name
    mr = MerchantRepository.new('./data/merchants.csv')

    result = mr.find_by_names('name')

    assert_equal 'name', result.name
    assert_instance_of Merchant, result
  end

  def test_it_returns_all_merchants_with_a_matching_name
    mr = MerchantRepository.new('./data/merchants.csv')
    name = 'name'

    result = mr.find_all_by_name(name)

    assert result.all? do |merchant|
      merchant.name == name
    end
  end

  def test_it_returns_an_empty_array_if_no_merchants_match_name
    mr = MerchantRepository.new('./data/merchants.csv')
    name = 'name2'

    result = mr.find_all_by_name(name)

    assert result.empty?
  end
end
