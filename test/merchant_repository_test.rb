require './test/test_helper'
require './lib/merchant_repository'
require './lib/merchant'
require 'csv'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :mr

  def setup
    mercs_file = CSV.open("./test/testdata/merchants_simple.csv",
                          headers: true,
                          header_converters: :symbol)
    csv_rows = mercs_file.to_a
    @mr = MerchantRepository.new(csv_rows)
  end

  def test_merchants_is_an_array_of_merchant_instances
    assert_equal Array, mr.merchants.class
    assert_equal true, mr.merchants.all? { |thing| thing.class == Merchant }
  end

  def test_merchants_is_instantiated_with_correct_attributes
    assert_equal 12334105, mr.merchants[0].id
    assert_equal 'Shopin1901', mr.merchants[0].name
  end

  def test_method_all_returns_array_known_merchant_instances
    assert_equal mr.merchants, mr.all
  end

  def test_method_find_by_id_returns_nil_or_merchant_instance
    merc_1 = mr.find_by_id(12334105)
    merc_2 = mr.find_by_id('shaq')
    assert_equal Merchant, merc_1.class
    assert_equal 12334105, merc_1.id
    assert_equal nil, merc_2
  end

  def test_method_find_by_name_returns_nil_or_merchant_instance
    merc_1 = mr.find_by_name("LolaMarleys")
    merc_2 = mr.find_by_name("LOLAMArleYS")
    merc_3 = mr.find_by_name("a one so very rare, exquisite merchant")
    assert_equal Merchant, merc_1.class
    assert_equal "LolaMarleys", merc_1.name
    assert_equal "LolaMarleys", merc_2.name
    assert_equal nil, merc_3
  end

  def test_method_find_all_by_name
    merc_name_1 = 'MotankiDarena'
    merc_name_2 = 'the'
    merc_name_3 = 'danosaurus rex'
    mercs_1 = mr.find_all_by_name(merc_name_1)
    mercs_2 = mr.find_all_by_name(merc_name_2)
    mercs_3 = mr.find_all_by_name(merc_name_3)
    assert_equal Array, mercs_1.class
    assert_equal 1, mercs_1.length
    assert_equal Array, mercs_2.class
    assert_equal 3, mercs_2.length
    assert_equal [], mercs_3
  end


end
