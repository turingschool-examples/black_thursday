require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
  end

  def test_to_create_a_sales_engine_object_we_use_the_factory
    assert_kind_of SalesEngine, @se
  end

  def test_sales_engine_can_create_CSV_objects
    skip
    binding.pry
    submitted =
    expected =

    assert_equal
  end

  def test_sales_engine_can_receive_one_csv_file

  end

  def test_sales_engine_can_receive_two_csv_files

  end

  def test_sales_engine_can_create_Merchant_Repos
    mr = @se.merchants
    expected = "#<Merchant:0"
    submitted = mr.find_by_name("CJsDecor").to_s

    assert submitted.include?(expected)
    assert_kind_of MerchantRepository, mr
  end

  def test_sales_engine_can_create_Items_Repos
    ir = @se.items
    expected = "#<Items:0"
    submitted = ir.find_by_name("510+ RealPush Icon Set").to_s

    assert submitted.include?(expected)
    assert_kind_of ItemRepository, ir
  end

end
