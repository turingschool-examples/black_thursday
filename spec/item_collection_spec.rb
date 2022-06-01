require './lib/merchant'
require './lib/merchant_collection'
require './lib/item'
require "./lib/item_collection"

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

 # it 'can find all with description' do
 #   expect(@ic.find_all_with_description("Gorgeous hand knitted baby bootees, knitted in the softest cream coloured wool, the soles are yellow and the bootees are finished with an orange pompom at the back. Would fit from new born up to two months.").last).to be_a(Item)
 #
 #   expect(@ic.find_all_with_description(description).length).to eq(24)
 # end

end
