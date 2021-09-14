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

  it "#find_all_with_description" do
    expect(@ir.find_all_with_description("asdfvds2344")).to eq []
    expect(@ir.find_all_with_description("I have sizes S, M, and L").length).to eq 1
    expect(@ir.find_all_with_description("I have sizes S, M, and L")[0].id).to eq 263407685
  end

  it "#find_all_by_price" do
    expect(@ir.find_all_by_price(-1)).to eq []
    expect(@ir.find_all_by_price(7500)).to be_a Array
    expect(@ir.find_all_by_price(7500).empty?).to be false
  end

  it "#find_all_by_price_in_range" do
    expect(@ir.find_all_by_price_in_range(-5..-1)).to eq []
    expect(@ir.find_all_by_price_in_range(0..1000)).to be_a Array
    expect(@ir.find_all_by_price_in_range(0..1000).empty?).to be false
  end

  it "#find_all_by_merchant_id" do
    expect(@ir.find_all_by_merchant_id(-1)).to eq []
    expect(@ir.find_all_by_merchant_id(12336642).length).to eq 2
  end

  it "#find_highest_id" do
    expect(@ir.find_highest_id).to be_a Integer
    expect(@ir.find_highest_id).to be > 263567376
  end
end