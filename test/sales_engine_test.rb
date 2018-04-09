require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items      => './data/items.csv',
      :merchants  => './data/merchants.csv'
      })
  end

  def test_it_returns_repositories
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of SalesEngine, @se
  end

  def test_it_returns_a_sales_analyst
    sa = @se.analyst
    assert_instance_of SalesAnalyst, sa
  end
end
