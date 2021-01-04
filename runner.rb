require './lib/sales_engine'
se = SalesEngine.from_csv({:items     => "./data/items.csv",
                           :merchants => "./data/merchants.csv"})
