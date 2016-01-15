require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    csv_object_of_merchants = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
    @mr = MerchantRepository.new(csv_object_of_merchants)
    #expected
    #expected buy weird
    #2nd kind of weird
    #totally wrong
  end

  def test_can_create_a_repo_of_merchants
    total_merchants = 475
    first_id        = 12334105
    last_id         = 12337411

    assert_equal total_merchants, @mr.all.count
    assert_equal first_id, @mr.all[0].id
    assert_equal last_id, @mr.all[-1].id
  end

  def test_all_merchants
    assert_equal 475, @mr.all.count
  end

  def test_find_by_name_exact_search
    merchant_name = "Shopin1901"
    expected      = merchant_name
    submitted     = @mr.find_by_name(merchant_name)

    assert_equal expected, submitted.name
  end

  def test_find_by_name_case_insensitve_search
    merchant_name = "Shopin1901"
    expected      = merchant_name
    submitted     = @mr.find_by_name(merchant_name.upcase)

    assert_equal expected, submitted.name
  end

  def test_find_by_name_case_incomplete_name
    merchant_name = "Shop"
    expected      = merchant_name
    submitted     = @mr.find_by_name(merchant_name.upcase)

    assert_nil submitted
  end

  def test_find_by_name_rejects_bad_name
    merchant_name = "BurgerKing"
    submitted     = @mr.find_by_name(merchant_name)

    assert_nil submitted
  end

  def test_find_by_given_merchant_id
    merchant_id = 12334132
    expected    = merchant_id
    submitted   = @mr.find_by_id(merchant_id)

    assert_equal expected, submitted.id
  end

  def test_find_by_id_rejects_bad_id
    merchant_id = 1
    expected    = merchant_id
    submitted   = @mr.find_by_id(merchant_id)

    assert_nil submitted
  end

  def test_find_all_by_name_given_single_character
    name_fragment = "S"
    expected      = 328
    submitted     = @mr.find_all_by_name(name_fragment)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_name_given_case_insensitive_fragment
    name_fragment = "SHOP"
    expected      = 26
    submitted     = @mr.find_all_by_name(name_fragment)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_name_with_special_char
    name_fragment = "!"
    expected      = []
    submitted     = @mr.find_all_by_name(name_fragment)

    assert_equal expected, submitted
  end

  def test_find_all_by_name_with_exact_match
    name_fragment = "Shopin1901"
    expected      = 1
    submitted     = @mr.find_all_by_name(name_fragment)

    assert_equal expected, submitted.count
  end

end
