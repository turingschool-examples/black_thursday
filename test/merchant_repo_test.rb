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
    mr = MerchantRepo.new
    mr.parse_headers('test/fixtures/merchant_sample_small.csv')
   assert_equal "12334105", mr.headers:[:id]
#trying to get this to pass
  end

end
