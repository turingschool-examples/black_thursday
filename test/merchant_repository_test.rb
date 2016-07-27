require './test/test_helper'
require './lib/merchant_repository'
require 'CSV'

class MerchantRepositoryTest < Minitest::Test

  # def setup
  #   @mr = MerchantRepository.new
  #   @merchants = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)
  # end

  def test_it_exists
    assert_instance_of MerchantRepository, MerchantRepository.new
  end

  def test_it_starts_with_no_merchants
    mr = MerchantRepository.new

    assert_equal 0, mr.merchants.count
  end

  def test_it_populates_repository_with_merchants
    mr = MerchantRepository.new
    merchants = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)
    mr.populate(merchants)

    assert_equal 10, mr.merchants.count
  end

  def test_it_returns_a_merchant_from_repository
    mr = MerchantRepository.new
    merchants = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)
    mr.populate(merchants)
    assert_instance_of Merchant, mr.merchants[merchants[0][:id]]
  end

  def test_it_returns_a_list_of_merchants
    mr = MerchantRepository.new
    merchants = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)
    mr.populate(merchants)

    assert_equal Array, mr.all.class
    assert_equal 10, mr.all.count
    assert_instance_of Merchant, mr.all.sample
  end

  def test_it_finds_the_merchant_by_id
    mr = MerchantRepository.new
    merchants = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)
    mr.populate(merchants)

    assert_instance_of Merchant, mr.find_by_id("12334105")
    assert_instance_of Merchant, mr.find_by_id("12334135")
    assert_equal nil, mr.find_by_id("1234567")
  end

  def test_it_finds_the_merchant_by_name
    mr = MerchantRepository.new
    merchants = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)
    mr.populate(merchants)

    assert_instance_of Merchant, mr.find_by_name("Shopin1901")
    assert_instance_of Merchant, mr.find_by_name("ShOPiN1901")
    assert_instance_of Merchant, mr.find_by_name("Keckenbauer")
    assert_instance_of Merchant, mr.find_by_name("KECKENBAUER")
    assert_equal nil, mr.find_by_name("onlineshop")
  end

  def test_it_finds_all_merchants_by_supplied_name_fragment
    mr = MerchantRepository.new
    merchants = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)
    mr.populate(merchants)

    assert_equal [], mr.find_all_by_name("piney")

    found_names = mr.find_all_by_name("pin").map { |merchant| merchant.name }
    assert_equal ["Shopin1901"], found_names

    found_names = mr.find_all_by_name("pIN").map { |merchant| merchant.name }
    assert_equal ["Shopin1901"], found_names

    found_names = mr.find_all_by_name("en").map { |merchant| merchant.name }
    assert_equal ["Keckenbauer", "GoldenRayPress"], found_names

    found_names = mr.find_all_by_name("EN").map { |merchant| merchant.name }
    assert_equal ["Keckenbauer", "GoldenRayPress"], found_names
  end
end
