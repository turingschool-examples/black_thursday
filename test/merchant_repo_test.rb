require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repo'



class MerchantRepoTest < Minitest::Test

  def test_it_loads_file
    mr = MerchantRepo.new
    contents = mr.load_file('test/fixtures/merchant_sample.csv')
    assert contents
  end


  def test_parse_headers
    skip
    mr = MerchantRepo.new

    mr.parse_headers('test/fixtures/merchant_sample_small.csv')

    assert_equal "12334105", result
  end

  def test_it_can_find_merchant_by_name
      mr = MerchantRepo.new
      mr.parse_headers('test/fixtures/merchant_sample_small.csv')

      merchant_1 = mr.find_by_name("Shopin1901")

      assert_equal "Shopin1901", merchant_1.name
  end

  def test_it_can_return_nil
      mr = MerchantRepo.new
      mr.parse_headers('test/fixtures/merchant_sample_small.csv')

      assert_nil mr.find_by_name("bethknight")
  end

  def test_it_can_find_all_merchants
    skip
    mr = MerchantRepo.new
    mr.parse_headers('test/fixtures/merchant_sample_small.csv')

    assert_equal 0, mr.all
  end

end
