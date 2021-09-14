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

  it "#all" do
    expect(@ir.all).to be_a Array
    expect(@ir.all.empty?).to be false
    expect(@ir.all[0]).to be_a Item
  end

  it "#find_by_id" do
    expect(@ir.find_by_id(263395237)).to be_a Item
    expect(@ir.find_by_id(263395617).name).to eq "Glitter scrabble frames"
    expect(@ir.find_by_id(2)).to eq nil
  end

  it "#find_by_name" do
    expect(@ir.find_by_name("510+ RealPush IcON SeT")).to be_a Item
    expect(@ir.find_by_name("510+ RealPush IcON SeT").id).to eq 263395237
    expect(@ir.find_by_name("")).to eq nil
  end

  it "#find_all_with_descirption" do
    expect(@ir.find_all_with_descirption("asdfvds2344")).to eq []
  end
end