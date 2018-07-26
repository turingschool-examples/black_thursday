require_relative "../test/test_helper"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test

def setup
  @sales_engine = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                  :merchants => "./data/merchants.csv"})
#  @sales_engine = SalesEngine.new(@merchants, @items)

  # @merchants = [@merchant_1 = {id: 12334105, name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
  # @merchant_2 = {id: 12334106, name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
  # @merchant_3 = {id: 12334107, name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
  # @merchant_4 = {id: 12334108, name: "Woody1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
  # @merchant_5 = {id: 12334109, name: "Fully1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
  # @merchant_6 = {id: 12334110, name: "Sleepy1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
  # @merchant_7 = {id: 12334111, name: "Happy1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
  # @merchant_8 = {id: 12334112, name: "Angry1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
  # @merchant_9 = {id: 12334113, name: "Turing1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
  # @merchant_10 = {id: 12334114, name: "Awesome1901", created_at: "2010-12-10", updated_at: "2011-12-04"}]
  #
  # @items = [@item_1 = {id: 263395237, name: "Cow1" , description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334195"},
  # @item_2 = {id: 263395238, name: "Cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334195"},
  # @item_3 = {id: 263395239, name: "Cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334195"},
  # @item_4 = {id: 263395210, name: "Moose1", description: "animal 2", unit_price: "1700", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334101"},
  # @item_5 = {id: 263395211, name: "Moose2", description: "animal 3", unit_price: "1800", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334102"},
  # @item_6 = {id: 263395212, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334103"},
  # @item_7 = {id: 263395213, name: "Cat", description: "animal 5", unit_price: "2000", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334104"},
  # @item_8 = {id: 263395214, name: "Dog", description: "animal 6", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334104"}]
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_it_loads_from_csv
    actual = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                  })
    assert_instance_of SalesEngine, actual
  end

end
