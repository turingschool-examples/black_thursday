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


end
