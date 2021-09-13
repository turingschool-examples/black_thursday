require 'csv'

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})



# class SalesEngine
#
#   attr_reader :items, :merchants
#
#   def initialize(data)
#     @items = data[:items]
#     @merchants = data[:merchants]
#   end
#
#   def from_csv
#   end
# end
