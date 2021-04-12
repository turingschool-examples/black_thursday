require './lib/sales_engine'
require './lib/item'
require './lib/merchant'


se = SalesEngine.new
se.from_csv({
                        merchants: './data/merchants.csv',
                        items: './data/items.csv'
                     })

p se.items_array.length
p se.merchants_array.length