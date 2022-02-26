require "./lib/item_repo"
require "./lib/sales_engine"
require "./lib/item"
require "pry"

RSpec.describe ItemRepository do
  se = SalesEngine.from_csv({
    items: "./data/items.csv",
    merchants: "./data/merchants.csv"
  })
  ir = ItemRepository.new(se.items_instanciator)

  it "is an instance of ItemRepository" do
    expect(ir).to be_an_instance_of(ItemRepository)
  end

  xit "can return an array of all item instances" do
    expect(ir.all.count).to eq 
  end
end
