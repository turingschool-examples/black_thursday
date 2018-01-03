require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < MiniTest::Test
  def test_all_returns_an_array_of_merchant_instances
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    result = mr.all

    assert result.all? do |element|
      element.class == Merchant
    end
  end

  def test_find_by_id_returns_nil_if_merchant_does_not_exist
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    assert_nil mr.find_by_id(789)
  end

  def test_find_by_id_returns_merchant_instance_with_matching_id
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    result = mr.find_by_id(12334113)

    assert_equal 12334113, result.id
    assert_instance_of Merchant, result
  end

  def test_find_by_name_returns_nil_if_merchant_does_not_exist
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    assert_nil mr.find_by_name('bill robbins')
  end

  def test_find_by_name_returns_merchant_instance_with_matching_name
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    result = mr.find_by_name('LolaMarleys')

    assert_equal 'LolaMarleys', result.name
    assert_instance_of Merchant, result
  end

  def test_find_by_name_returns_merchant_instance_with_matching_name_case_insensitive
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')

    result = mr.find_by_name('lolamarleys')

    assert_equal 'LolaMarleys', result.name
  end

  def test_it_returns_all_merchants_with_a_matching_name
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')
    name = 'name'

    result = mr.find_all_by_name(name)

    assert result.all? do |merchant|
      merchant.name == name
    end
  end

  def test_it_returns_an_empty_array_if_no_merchants_match_name
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated.csv')
    name = 'name2'

    result = mr.find_all_by_name(name)

    assert result.empty?
  end
end
