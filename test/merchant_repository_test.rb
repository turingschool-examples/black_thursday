require './test/test_helper'
require './lib/merchant_repository'
# require './lib/merchant'
require 'csv'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :mr

  def setup
    fixture = CSV.open('./test/fixtures/merchants_fixture.csv',
                          headers: true,
                          header_converters: :symbol)
    csv_rows = fixture.to_a
    @mr = MerchantRepository.new(csv_rows)
  end

  def test_method_items_returns_array_of_merchants
    assert_instance_of Array, mr.merchants
    assert_equal true, mr.merchants.all? { |thing| thing.class == Merchant }
  end

  def test_method_all_returns_array_of_merchants
    assert_equal mr.merchants, mr.all
  end

  def test_method_find_by_id_returns_nil_or_merchant
    merchant =     mr.find_by_id(1000)
    merchant_nil = mr.find_by_id(9001)
    assert_instance_of Merchant, merchant
    assert_equal 1000,           merchant.id
    assert_equal nil,            merchant_nil
  end

  def test_method_find_by_name_returns_nil_or_merchant
    merchant_lowercase = mr.find_by_name("adam's bar")
    merchant_uppercase = mr.find_by_name("ADAM'S BAR")
    merchant_nil =       mr.find_by_name("mr's shack")
    assert_instance_of Merchant, merchant_lowercase
    assert_equal "adam's bar",   merchant_lowercase.name
    assert_equal "adam's bar",   merchant_uppercase.name
    assert_equal nil,            merchant_nil
  end

  def test_method_find_all_by_name_returns_array_of_merchants
    merchants =           mr.find_all_by_name("adam's bar")
    merchants_multiple =  mr.find_all_by_name("BAR")
    merchants_empty =     mr.find_all_by_name("mr's shack")
    assert_instance_of Array, merchants
    assert_equal mr.merchants[0], merchants[0]
    assert_equal true,        merchants_multiple.length > 1
    assert_equal [],          merchants_empty
  end

  def test_method_find_all_items_by_merchant_id_returns_items
    mock_se = Minitest::Mock.new
    mr = MerchantRepository.new([], mock_se)
    mock_se.expect(:find_all_items_by_merchant_id, nil, [1000])
    mr.find_all_items_by_merchant_id(1000)
    assert mock_se.verify
  end

  def test_method_find_all_items_by_merchant_id_returns_items
    mock_se = Minitest::Mock.new
    mr = MerchantRepository.new([], mock_se)
    mock_se.expect(:find_all_items_by_merchant_id, nil, [1000])
    mr.find_all_items_by_merchant_id(1000)
    assert mock_se.verify
    
  end
end
