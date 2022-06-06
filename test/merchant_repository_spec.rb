require './lib/merchant'
require './lib/merchant_repository'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'

RSpec.describe MerchantRepository do

  let(:sales_engine) {SalesEngine.from_csv({
     :items     => "./data/items.csv",
     :merchants => "./data/merchants.csv",
     :invoices => "./data/invoices.csv",
     :invoice_items => "./data/invoice_items.csv",
     :transactions => "./data/transactions.csv",
     :customers => "./data/customers.csv"
     })}
  let(:merchant) {sales_engine.merchants}

 it "exists" do
   expect(merchant).to be_an(MerchantRepository)
 end

 it "has attributes" do
   expect(merchant.all).to be_an(Array)
   expect(merchant.all.first.name).to eq("Shopin1901")
   expect(merchant.all.first.id).to eq(12334105)
   expect(merchant.all.length).to eq(475)
 end

 it "can find a merchant by id" do
   #Should we change merchant ids to integers?
   expect(merchant.find_by_id(12334281).name).to eq("justMstyle")
   expect(merchant.find_by_id(00000000)).to eq(nil)
 end

 it "can find a merchant by name" do
   expect(merchant.find_by_name("HooksforBooks")).to be_an(Merchant)
   expect(merchant.find_by_name("hooksforbooks")).to be_an(Merchant)
   expect(merchant.find_by_name("HOOKSFORBOOKS")).to be_an(Merchant)
   expect(merchant.find_by_name("ParkerAndMarysDungeonWithDragons")).to eq(nil)
 end

 it "can find all by name" do
   expect(merchant.find_all_by_name("Gran")).to be_an(Array)
   expect(merchant.find_all_by_name("Gran").first.name).to eq("GranadaFotoBaby")
   expect(merchant.find_all_by_name("Gran").last.name).to eq("RigRanch")
   expect(merchant.find_all_by_name("Gran").count).to eq(5)
   expect(merchant.find_all_by_name("ParkerAndMarysDungeonWithDragons")).to eq([])
   expect(merchant.find_all_by_name("style")).to be_an(Array)
   expect(merchant.find_all_by_name("style").count).to eq(3)
 end

 it "create an instance with attributes" do
   attributes = {
     :name => "TiltedTurtles"
   }
   merchant.create(attributes)
   expect(merchant.find_by_id(12337412).name).to eq("TiltedTurtles")
   expect(merchant.all.last.id).to eq(12337412)
 end

 it "can update the name of an merchant" do
   attributes = {
     :name => "MEEEEEPS"
   }
   expect(merchant.find_by_id(12334669).name).to eq("BEEEPS")
   merchant.update(12334669, attributes)
   expect(merchant.find_by_id(12334669).name).to eq("MEEEEEPS")
 end

 it "can delete merchants based on id" do
   expect(merchant.all.length).to eq(475)
   merchant.delete(12334669)
   expect(merchant.all.length).to eq(474)
 end
end
