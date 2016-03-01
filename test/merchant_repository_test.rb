require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'pry'
require_relative '../lib/merchant_repository'
require_relative '../sales_engine'

class MerchantRepositoryTest < Minitest::Test
  def setup
    sales_engine = SalesEngine.new
    sales_engine.from_csv({:merchants => './fixtures/merchants_fixture.csv'})
    # @mr = MerchantRepository.new(sales_engine.csv_content[:merchants])
    # binding.pry
    @mr = sales_engine.merchants
  end
  def test_initalize_organizes_row_values
    expected_ids = ["12334105", "12334112", "12334113"]
    expected_names = ["Shopin1901", "Candisart", "MiniatureBikez"]
    expected_created_at = ["2010-12-10", "2009-05-30", "2010-03-30"]
    expected_updated_at = ["2011-12-04", "2010-08-29", "2013-01-21"]
    assert_equal expected_ids, @mr.id
    assert_equal expected_names, @mr.name
    assert_equal expected_created_at, @mr.created_at
    assert_equal expected_updated_at, @mr.updated_at
  end

end
