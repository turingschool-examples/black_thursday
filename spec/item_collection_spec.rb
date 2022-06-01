require './lib/merchant'
require "./lib/merchant_collection"
require "./lib/item"
require "./lib/item_collection"

RSpec.describe ItemCollection do
 before :each do
   @ic = ItemCollection.new("./data/items.csv")
 end


end
