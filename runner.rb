require './lib/sales_engine'
require './lib/item_repository'
require './lib/item'

this = SalesEngine.new

 puts this.item_repository.items[1].id
