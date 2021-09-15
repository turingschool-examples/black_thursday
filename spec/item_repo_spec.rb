require './lib/item_repository'
require 'csv'

RSpec.describe do

  it 'exists' do
    repo = ItemRepository.new("./data/items.csv")
    expect(repo).to be_an_instance_of(ItemRepository)
  end

  it "converts the csv to a hash" do
    repo = ItemRepository.new("./data/items.csv")
    results = repo.to_hash("./data/items.csv")
    expect(results).to be_a(Hash)
  end

  it 'adds keys to item instances array' do
  repo = ItemRepository.new("./data/items.csv")
  repo.to_hash("./data/items.csv")
  expect(repo.all.count).to eq(1367)
  end

end
