require './lib/item_repository'

RSpec.describe ItemRepository do

  before :each do
    @item_repository = ItemRepository.new('./data/items.csv')
  end

  it "exists" do
    expect(@item_repository).to be_a(ItemRepository)
  end

  it "has an array of Item instances (all)" do
    expect(@item_repository.all).to be_a(Array)
    expect(@item_repository.all.length).to eq(1367)
    expect(@item_repository.all.first).to be_a(Item)
    expect(@item_repository.all.first.id).to eq(263395237)
  end

  it "can find_by_id" do
    expect(@item_repository.find_by_id(999)).to be_nil
    expect(@item_repository.find_by_id(263395237)).to be_a(Item)
    expect(@item_repository.find_by_id(263395237).id).to eq(263395237)
    expect(@item_repository.find_by_id(263395237).name).to eq("510+ RealPush Icon Set")
  end

  it "can find_by_name" do
    expect(@item_repository.find_by_name("X")).to be_nil
    expect(@item_repository.find_by_name("510+ RealPush Icon Set")).to be_a(Item)
    expect(@item_repository.find_by_name("510+ RealPush Icon Set").id).to eq(263395237)
    expect(@item_repository.find_by_name("510+ RealPush Icon Set").name).to eq("510+ RealPush Icon Set")
  end

  it "can find_all_with_description" do
    expect(@item_repository.find_all_with_description("xyz")).to eq([])
    expect(@item_repository.find_all_with_description("planet earth").length).to eq(1)
    expect(@item_repository.find_all_with_description("scrabble").first.name).to eq("Glitter scrabble frames")
    expect(@item_repository.find_all_with_description("dribbble").first.id).to eq(263395237)
  end

  it "can find_all_by_price" do
    expect(@item_repository.find_all_by_price(3300).length).to eq(1)
    expect(@item_repository.find_all_by_price(55000).length).to eq(2)
    expect(@item_repository.find_all_by_price(678)).to eq([])
  end

  it "can find_all_by_price_in_range" do
    expect(@item_repository.find_all_by_price_in_range(3299..3301).length).to eq(1)
    expect(@item_repository.find_all_by_price_in_range(725000..999999).length).to eq(1)
    expect(@item_repository.find_all_by_price_in_range(725000..999999).first.id).to eq(263446405)
  end

  it "can find_all_by_merchant_id" do
    expect(@item_repository.find_all_by_merchant_id(12334123).length).to eq(25)
    expect(@item_repository.find_all_by_merchant_id(12334971).length).to eq(5)

  end

  xit "can create new Item instances" do

  end

  xit "can update instances" do

  end

  xit "can delete instances" do

  end
end
