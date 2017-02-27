require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test

  def test_pull_csv
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_instance_of CSV, mr.pull_csv
  end

  def test_parse_csv
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_instance_of Merchant, mr.merchants_array[0]
  end

  def test_find_by_id
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_equal 'FlavienCouche', mr.find_by_id(12334195).name
    refute_equal 'FlavienCouche', mr.find_by_id(12334155).name
    assert_nil   mr.find_by_id(100)
  end

  def test_find_by_name
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_equal 12334159, mr.find_by_name('SassyStrangeArt').id
    assert_equal 12334159, mr.find_by_name('SASSystrangeart').id
  end

  def test_find_all_by_name
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_equal 2, mr.find_all_by_name('ham').count
    assert_equal "TheHamAndRat", mr.find_all_by_name('ham')[0].name
    assert_equal [], mr.find_all_by_name('efbwrhjbfr')
  end
end
