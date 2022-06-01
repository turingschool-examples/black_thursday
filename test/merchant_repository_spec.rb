require './lib/merchant'
require './lib/merchant_repository'
# require './lib/item'
# require './lib/item_repository'

RSpec.describe MerchantRepository do
  file_path = "./data/merchants.csv"
 let(:merchant) {MerchantRepository.new(file_path)}

 it "exists" do
   expect(merchant).to be_an(MerchantRepository)
 end

 it "has attributes" do
   expect(merchant.all).to be_an(Array)
   expect(merchant.all.first.name).to eq("Shopin1901")
   expect(merchant.all.first.id).to eq("12334105")
   expect(merchant.all.length).to eq(475)
 end

 it "can find a merchant by id" do
   #Should we change merchant ids to integers?
   expect(merchant.find_by_id("12334281")).to be_an(Merchant)
   expect(merchant.find_by_id("00000000")).to eq(nil)
 end

 it "can find a merchant by name" do
   expect(merchant.find_by_name("HooksforBooks")).to be_an(Merchant)
   expect(merchant.find_by_name("hooksforbooks")).to be_an(Merchant)
   expect(merchant.find_by_name("HOOKSFORBOOKS")).to be_an(Merchant)
   expect(merchant.find_by_name("ParkerAndMarysDungeonWithDragons")).to eq(nil)
 end


end
