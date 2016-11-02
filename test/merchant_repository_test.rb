require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
      :merchants => "./data_fixtures/merchants_fixture.csv",
    })
  end

  def test_all_returns_an_array
    merchant_repository = sales_engine.merchants
    assert_kind_of Array, merchant_repository.all
  end

  def test_all_returns_an_array_of_all_merchant_objects
    merchant_repository = sales_engine.merchants
    merchant_repository.all.each {|merchant| assert_kind_of Merchant, merchant}
  end

  def test_all_includes_all_20_merchant_objects_from_merchants_fixture
    merchant_repository = sales_engine.merchants
    assert_equal 20, merchant_repository.all.length
  end

  def test_find_by_id_returns_instance_with_matching_id
    id = 12334155
    merchant_repository = sales_engine.merchants
    merchant = merchant_repository.find_by_id(id)
    assert_kind_of Merchant, merchant
    assert_equal id, merchant.id
  end

  def test_find_by_id_returns_nil_with_matching_id
    id = 99999999
    merchant_repository = sales_engine.merchants
    assert_nil merchant_repository.find_by_id(id)
  end

  def test_find_by_name_returns_instance_with_matching_name
    name = 'SassyStrangeArt'
    merchant_repository = sales_engine.merchants
    merchant = merchant_repository.find_by_name(name)
    assert_kind_of Merchant, merchant
    assert_equal name, merchant.name
  end

  def test_find_by_name_returns_instance_with_matching_name_all_caps
    name_upcase = 'SASSYSTRANGEART'
    name = 'SassyStrangeArt'
    merchant_repository = sales_engine.merchants
    merchant = merchant_repository.find_by_name(name_upcase)
    assert_kind_of Merchant, merchant
    assert_equal name, merchant.name
  end

  def test_find_by_name_returns_nil_when_there_are_no_matches
    name = 'NothingFactory'
    merchant_repository = sales_engine.merchants
    assert_nil merchant_repository.find_by_name(name)
  end

  def test_find_all_by_name_returns_the_one_match_in_fragment
    name = 'SassyStrangeArt'
    merchant_repository = sales_engine.merchants
    merchants = merchant_repository.find_all_by_name(name)
    assert merchants.one? {|merchant| merchant.name == name}
  end

  def test_find_all_by_name_returns_the_one_match_in_fragment_all_downcase
    name_downcase = 'sassystrangeart'
    name = 'SassyStrangeArt'
    merchant_repository = sales_engine.merchants
    merchants = merchant_repository.find_all_by_name(name_downcase)
    assert merchants.one? {|merchant| merchant.name == name}
  end

  def test_find_all_by_name_returns_all_matches_to_fragment
    name1 = 'Shopin1901'
    name2 = 'thepurplepenshop'
    fragment = 'shop'
    merchant_repository = sales_engine.merchants
    merchants = merchant_repository.find_all_by_name(fragment)
    assert merchants.one? {|merchant| merchant.name == name1}
    assert merchants.one? {|merchant| merchant.name == name2}
  end

  def test_find_all_by_name_returns_empty_array_when_no_matches_exist
    fragment = 'thiswouldneverbeinanetsyshopname'
    merchant_repository = sales_engine.merchants
    merchants = merchant_repository.find_all_by_name(fragment)
    assert_equal [], merchants
  end

end
