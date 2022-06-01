require './lib/item_repository'

RSpec.describe ItemRepository do
  before :each do
    @item_repo = ItemRepository.new("./data/items.csv")
  end

  it "will be an instance of ItemRepository" do
    expect(@item_repo).to be_instance_of ItemRepository
  end

  it "has an all function" do
    expect(@item_repo.all.class).to equal(Array)
    expect(@item_repo.all[0].class).to equal(Item)
    expect(@item_repo.all[0].name).to eq("510+ RealPush Icon Set")
  end

  it "has a find by id function" do
    expect(@item_repo.find_by_id(263395237).name).to eq("510+ RealPush Icon Set")
    expect(@item_repo.find_by_id(123456)).to equal(nil)
  end

  it "has a find by name function" do
    expect(@item_repo.find_by_name("510+ RealPush Icon Set").id).to eq(263395237)
    expect(@item_repo.find_by_name("510+ REALPUSH Icon Set").id).to eq(263395237)
    expect(@item_repo.find_by_name("MINNIE MUG").id).to eq(nil)
  end

  it "can find items by description" do
    expect(@item_repo.find_all_with_description("tkjlds;afdkla")).to eq([])
    expect(@item_repo.find_all_with_description("Facebook")).to eq(XXX)
  end
end
