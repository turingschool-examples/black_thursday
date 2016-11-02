require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/merchant'

class MerchantTest < Minitest::Test


RAW_DATA = CSV.open './fixtures/merchant_single.csv', headers: true, header_converters: :symbol


  def test_it_exists
    assert Merchant.new(RAW_DATA)
  end
  def test_it_has_id_and_name
    merch = Merchant.new(RAW_DATA, self)
    
    assert_equal 1234, merch.id
    assert_equal "Turing School", merch.name
  end
  
end