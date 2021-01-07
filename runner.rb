require_relative './lib/sales_engine'
require "csv"
require "pry"

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

se.items.find_all_with_descripition("design")
# binding.pry
# 0
# item.new for each CSV::ROW

#inside of item repo and merchant repo
# itemrepository = []
# CSV.foreach(@items, headers: true, header_converters: :symbol){|row| itemrepository << row}
