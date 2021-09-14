require "CSV"
require "Rspec"
require "./lib/item_repository"

describe ItemRepository do
  before :each do
    @ir = ItemRepository.new('./data/items.csv')
  end

  it 'is an instance of ItemRepository' do
    expect(@ir).to be_a ItemRepository
  end

  it "creates an array full of hashes from the csv" do
    expect(@ir.to_array).to be_a Array
    expect(@ir.to_array.empty?).to be false
  end
end