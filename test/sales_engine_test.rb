require_relative './test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv({
        :items => './data/test_items.csv',
        :merchants => './data/test_merchants.csv'
    })

    assert_instance_of SalesEngine, se
  end

<<<<<<< HEAD
  def test_it_can_initialize_from_csv
    se = SalesEngine.from_csv()
=======
  def test_it_can_create_repos_from_csv
    se = SalesEngine.from_csv({
        :items => './data/test_items.csv',
        :merchants => './data/test_merchants.csv'
    })
    actual = se.merchants.find_by_id(12334105).name

    assert_equal "Shopin1901", actual
  end

>>>>>>> f383e696193518f2683634daad455d6f6829953c
end
