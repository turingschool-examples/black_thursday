require 'CSV'
require 'pry'
require_relative '../lib/item_repository.rb'
require_relative '../lib/item.rb'

RSpec.describe ItemRepository do
  it "initializes" do
    repo = ItemRepository.new [Item.new({id: 1, name: "test", description: "test_description", unit_price: 1, created_at: "8:07pm UTC", updated_at: "2:34pm UTC", merchant_id: 001})]
    expect(repo).to be_an_instance_of(ItemRepository)
    expect(repo.all[0]).to be_an_instance_of(Item)
  end

  it "initializes #from_csv" do
    repo = ItemRepository.from_csv("./data/items_short.csv")
    expect(repo).to be_an_instance_of(ItemRepository)
    expect(repo.all.length).to eq(3)
    expect(repo.all[0]).to be_an_instance_of(Item)
  end


end
