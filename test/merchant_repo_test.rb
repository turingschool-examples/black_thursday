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

    assert_equal "12334105", merchant
  end

  def test_it_can_find_merchant_by_name
      mr = MerchantRepo.new

      mr.parse_headers('test/fixtures/merchant_sample_small.csv')

      search_repo = mr.find_by_name("Shopin1901")

      assert_equal "Shopin1901", search_repo.name
  end


end
