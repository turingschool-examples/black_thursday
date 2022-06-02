require './lib/merchant'
require './lib/merchant_collection'
require './lib/item'
require "./lib/item_collection"
require 'bigdecimal'

RSpec.describe ItemCollection do
 before :each do
   @ic = ItemCollection.new("./data/items_sample.csv")
 end

 it 'exists & has attributes' do
   expect(@ic).to be_a(ItemCollection)
   expect(@ic.all).to be_a(Array)
   expect(@ic.all.length).to eq(41)
 end

 it 'returns data from our item array' do
   expect(@ic.all.first.id).to eq("263395237")
   expect(@ic.all.first).to be_a(Item)
   expect(@ic.all.last.name).to eq("Knitted wool sweater &quot;Rose&quot;")
   expect(@ic.all.first.merchant_id).to eq("12334141")
 end

 it 'can find an item by id' do
   expect(@ic.find_by_id("263395237")).to be_a(Item)
   expect(@ic.find_by_id("263400305").name).to eq("Magnifique toile Street Art/Modern Art - Nike Air Max")
   expect(@ic.find_by_id("263397843").name).to eq("Wooden pen and stand")
   expect(@ic.find_by_id("263397867").id).to eq("263397867")
 end

 it 'can find an item by name' do
   expect(@ic.find_by_name("Wooden pEn and sTand")).to be_a(Item)
   expect(@ic.find_by_name("Le Câlin").id).to eq("263397919")
   expect(@ic.find_by_name("green footed Ceramic bowl").id).to eq("263399037")
 end

 it 'can find all with description' do
   expect(@ic.find_all_with_description("Disney glitter frames\n\nAny colour glitter available and can do any characters you require\n\nDifferent colour scrabble tiles\n\nBlue\nBlack\nPink\nWooden").last.name).to eq("Disney scrabble frames")
 end

 it 'can find all items by price' do
   expect(@ic.find_all_by_price("60000").count).to eq(4)
   expect(@ic.find_all_by_price("1350").count).to eq(1)
 end

 it 'can find all items within a price range' do
   range = 2000..9000
   range_1 = 30000..60000
   expect(@ic.find_all_by_price_in_range(range).count).to eq(16)
   expect(@ic.find_all_by_price_in_range(range_1).count).to eq(9)
 end

 it 'can find all items by merchant id' do
   expect(@ic.find_all_by_merchant_id(merchant_id)).to be_a(Item)
   # expect(@ic.find_all_by_merchant_id(merchant_id).name).to eq()
   # expect(@ic.find_all_by_merchant_id(merchant_id)).to eq()
   # expect(@ic.find_by_id("263397867").id).to eq("263397867")
 end


end
