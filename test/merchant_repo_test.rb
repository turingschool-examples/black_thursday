require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repo'
require 'csv'
require 'pry'

class MerchantRepoTest < Minitest::Test
  attr_reader :file, 
              :sales_engine

  def setup
    @file = "./data/small_merchant_file.csv"
    @sales_engine = Minitest::Mock.new
  end

  def test_it_has_a_class
    m = MerchantRepo.new(file, sales_engine)
    assert_equal MerchantRepo, m.class
  end

  def test_it_can_display_all_items
    m = MerchantRepo.new(file, sales_engine)
    assert m.all
  end

  def test_it_can_search_by_id
    m = MerchantRepo.new(file, sales_engine)
    assert_equal "GoldenRayPress", m.find_by_id(12334135).name
  end

  def test_it_returns_nil_given_false_merchant_id
    m = MerchantRepo.new(file, sales_engine)
    assert_equal nil, m.find_by_id(0777665)
  end

  def test_it_can_find_by_name
    m = MerchantRepo.new(file, sales_engine)
    assert_equal 12334135, m.find_by_name("GoldenRayPress").id
  end

   def test_it_returns_nil_given_false_merchant_name
    m = MerchantRepo.new(file, sales_engine)
    assert_equal nil, m.find_by_name("xywndso")
  end

  def test_it_can_find_a_merchant_given_fragment
    m = MerchantRepo.new(file, sales_engine)
    assert_equal "GoldenRayPress", m.find_all_by_name("gold").first.name
  end

  def test_it_can_find_all_merchants_given_fragment
    m = MerchantRepo.new(file, sales_engine)
    assert_equal "Shopin1901", m.find_all_by_name("Shop").first.name
  end

  def test_it_returns_empty_array_given_illegitimate_fragment
    m = MerchantRepo.new(file, sales_engine)
    assert_equal [], m.find_all_by_name("pizza")
  end
end
