require_relative 'test_helper'
# require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @path = "./data/merchants_fixture.csv"
  end

  def test_it_exists
    mr = MerchantRepository.new(@path)
    assert_instance_of MerchantRepository, mr
  end

  def test_can_make_merchants
    mr = MerchantRepository.new(@path)
    assert mr.all[0]
    assert_instance_of Merchant, mr.all[0]
  end

  def test_all_returns_all_merchants
    mr = MerchantRepository.new(@path)
    merchants = mr.all
    assert merchants.all?{ |merchant| merchant.is_a?(Merchant)}
    assert_equal 10, mr.all.count
  end

  def test_finds_by_id
    mr = MerchantRepository.new(@path)
    found = mr.find_by_id(12334105)
    not_found = mr.find_by_id(9999999)

    assert_equal 12334105, found.id
    assert_nil not_found
  end

  def test_can_find_by_name
    mr = MerchantRepository.new(@path)
    found = mr.find_by_name("SHOPIN1901")
    not_found = mr.find_by_name("Mr.McCoolDude")

    assert_equal "Shopin1901", found.name
    assert_nil not_found
  end

  def test_can_find_all_by_name
    mr = MerchantRepository.new(@path)
    found_s = mr.find_all_by_name("s")
    found_marleys = mr.find_all_by_name("marleys")

    assert_equal "Shopin1901", found_s[0].name
    assert_equal "Candisart", found_s[1].name
    assert_equal "LolaMarleys", found_s[2].name
    assert_equal "perlesemoi", found_s[3].name 
    assert_equal "LolaMarleys", found_marleys[0].name
    assert_nil found_marleys[1]

    
  end

end