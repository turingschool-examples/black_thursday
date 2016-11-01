require 'csv'

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

mr = se.merchants
merchant = mr.find_by_name("CJsDecor")
# => <Merchant>

item = se.items.find_by_id(20)
item.merchant
# => <merchant>
