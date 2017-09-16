require './test/test_helper'
require './lib/merchant_repository'



class MerchantRepositoryTest < Minitest::Test

  attr_reader :merchant_repo
  def setup
    @merchant_repo = Fixture.repo(:merchants)
  end

  def merchant_12334105_expected
    {
      id: 12334105,
      name: 'Shopin1901',
      created_at: Time.parse('2010-12-10'),
      updated_at: Time.parse('2011-12-04')
    }
  end

  def test_initialize_takes_a_sales_engine_and_an_array_of_record_data
    args = [Fixture.sales_engine, Fixture.data[:merchants]]
    assert_instance_of MerchantRepository, MerchantRepository.new(*args)
  end

  def test_all_returns_an_array_of_all_merchants
    assert_instance_of Array, merchant_repo.all
    assert merchant_repo.all.all?{ |merchant| merchant.is_a? Merchant }
  end

  def test_find_by_id_returns_merchant_with_that_id_if_contained
    merchant = merchant_repo.find_by_id(12334105)
    assert_instance_of Merchant, merchant
    assert_equal 12334105, merchant.id
  end

  def test_find_by_id_returns_nil_if_not_contained
    assert_nil merchant_repo.find_by_id(-1)
  end

  def test_find_by_name_returns_merchant_with_that_name_if_contained
    merchant = merchant_repo.find_by_name('Shopin1901')
    assert_instance_of Merchant, merchant
    assert_equal 'Shopin1901', merchant.name
  end

  def test_find_by_name_returns_matching_instance_no_matter_case
    merchant = merchant_repo.find_by_name('sHoPiN1901')
    assert_instance_of Merchant, merchant
    assert_equal 'Shopin1901', merchant.name
  end

  def test_find_by_name_returns_nil_if_no_match
    assert_nil merchant_repo.find_by_name("!@{$%^&}$$$")
  end

  def test_find_all_by_name_returns_empty_array_if_no_matches
    assert_equal [], merchant_repo.find_all_by_name("!@{$%^&}$$$")
  end

  def test_find_all_by_name_returns_all_that_match
    skip
    assert_equal 5, merchant_repo.find_all_by_name("merchant").count
    assert_equal 6, merchant_repo.find_all_by_name("chant").count
  end

  def test_find_all_by_name_returns_all_that_match_case_insensitive
    skip
    assert_equal 5, merchant_repo.find_all_by_name("merCHANT").count
  end

end
