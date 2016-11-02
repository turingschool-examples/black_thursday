require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'
require 'csv'

class MerchantRepoTest < Minitest::Test

  def test_it_has_a_class
    m = MerchantRepo.new
    assert_equal MerchantRepo, m.class
  end

  def test_it_can_display_all_items
    m = MerchantRepo.new
    m.parse_file("./data/small_merchant_file.csv")
    assert m.all
  end

  def test_it_can_search_by_id
    m = MerchantRepo.new
    m.parse_file("./data/small_merchant_file.csv")
    assert_equal ["CERAMICANDCO"], m.find_by_id(12334284)
  end

  def test_it_returns_nil_given_false_merchant_id
    m = MerchantRepo.new
    m.parse_file("./data/small_merchant_file.csv")
    assert_equal nil, m.find_by_id(0777665)
  end

  def test_it_can_find_by_name
    skip
    m = MerchantRepo.new
    m.parse_file("./data/small_merchant_file.csv")
    assert_equal ["#<Merchant:0x007fded9983ab8>"], m.find_by_name("CERAMICANDCO")
  end

   def test_it_returns_nil_given_false_merchant_name
    m = MerchantRepo.new
    m.parse_file("./data/small_merchant_file.csv")
    assert_equal nil, m.find_by_name("poo")
  end

  def test_it_can_find_a_merchant_given_fragment
    skip
    m = MerchantRepo.new
    m.parse_file("./data/small_merchant_file.csv")
    assert_equal ["CERAMICANDCO"], m.find_all_by_name("ceram")
  end

  def test_it_can_find_all_merchants_given_fragment
    skip
    m = MerchantRepo.new
    m.parse_file("./data/small_merchant_file.csv")
    assert equal ["CERAMICANDCO"], m.find_all_by_name("ceram")
  end

  def test_it_returns_empty_array_given_illegitimate_fragment
    skip
    m = MerchantRepo.new
    m.parse_file("./data/small_merchant_file.csv")
    assert equal [], m.find_all_by_name("pizza")
  end
end
