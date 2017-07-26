se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
- items: returns instance of ItemRepository with all instances loaded
ir   = se.items
item = ir.find_by_name("Item Repellat Dolorum")

- merchants: returns instance of MerchantRepository with all instances loaded
mr = se.merchants
merchant = mr.find_by_name("CJsDecor")

class SalesEngineTest <Minitest::Test
  def test_initialize
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    assert_instance_of SalesEngine, salesengine
    assert_instance_of ItemRepository, salesengine.items
    assert_instance_of MerchantRepository, salesengine.merchants
  end

end
