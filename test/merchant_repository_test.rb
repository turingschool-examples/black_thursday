require './test/test_helper'
require './lib/merchant_repository'
require './lib/file_extractor'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :mr
  
  def setup
    @mr = MerchantRepository.new("./test/fixtures/merchants_sample.csv")
  end

  def test_it_exists
    assert_instance_of MerchantRepository, mr
  end

  def test_it_formats_merchant_info
    merchants_data = FileExtractor.extract_data("./test/fixtures/merchants_sample.csv")

    result = {:id=>"12334105", :name=>"Shopin1901"}
    assert_equal result, mr.format_merchant_info(merchants_data[0])

    result = {:id=>"12334145", :name=>"BowlsByChris"}
    assert_equal result, mr.format_merchant_info(merchants_data[9])

    result = {:id=>"12334132", :name=>"perlesemoi"}
    assert_equal result, mr.format_merchant_info(merchants_data[5])
  end

  def test_it_populates_repository_with_the_correct_amount_of_sample_merchants
    assert_equal 10, mr.merchants.count
  end

  def test_it_returns_a_merchant_from_repository
    assert_instance_of Merchant, mr.merchants[12334132]
  end

  def test_it_returns_a_full_list_of_merchants_based_on_sample_size
    assert_equal Array,          mr.all.class
    assert_equal 10,             mr.all.count
    assert_instance_of Merchant, mr.all.sample
  end

  def test_it_finds_the_merchant_by_id
    assert_instance_of Merchant, mr.find_by_id(12334105)
    assert_instance_of Merchant, mr.find_by_id(12334135)
    assert_equal nil,            mr.find_by_id(1234567)
  end

  def test_it_finds_the_merchant_by_name
    assert_instance_of Merchant, mr.find_by_name("Shopin1901")
    assert_instance_of Merchant, mr.find_by_name("ShOPiN1901")
    assert_instance_of Merchant, mr.find_by_name("Keckenbauer")
    assert_instance_of Merchant, mr.find_by_name("KECKENBAUER")
    assert_equal nil, mr.find_by_name("onlineshop")
  end

  def test_it_finds_all_merchants_that_match_a_name_fragment
    assert_equal [], mr.find_all_by_name("piney")

    found_names = mr.find_all_by_name("pin").map do |merchant|
      merchant.name
    end
    assert_equal ["Shopin1901"], found_names

    found_names = mr.find_all_by_name("pIN").map do |merchant|
      merchant.name
    end
    assert_equal ["Shopin1901"], found_names

    found_names = mr.find_all_by_name("en").map do |merchant|
      merchant.name
    end
    assert_equal ["Keckenbauer", "GoldenRayPress"], found_names

    found_names = mr.find_all_by_name("EN").map do |merchant|
      merchant.name
    end
    assert_equal ["Keckenbauer", "GoldenRayPress"], found_names
  end
end
