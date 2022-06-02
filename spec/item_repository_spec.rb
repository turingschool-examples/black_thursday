require'./lib/item'
require'./item_repository'

RSpec.describe ItemRepository do
  before :each do
    @item_repository = ItemRepository.new("./data/items.csv")
  end

  it 'exists' do
    expect(@item_repository).to be_a ItemRepository
  end

  it 'returns an array of all item instances' do
    expect(@item_repository.all).to be_a Array
    expect(@item_repository.all.count).to eq(1367)
  end

  it 'can find by id' do
    expect(@item_repository.find_by_id(263395237)).to eq(@item_repository.all.first)
    expect(@item_repository.find_by_id(1233)).to eq(nil)
    expect(@item_repository.find_by_id(263395237)).to be_a(Item)
  end

  it "can find_by_name" do

    expect(@item_repository.find_by_name("510+ RealPush Icon Set")).to eq(@item_repository.all.first)
    expect(@item_repository.find_by_name("XYZ")).to eq(nil)
    expect(@item_repository.find_by_name("510+ RealPush Icon Set")).to be_a(Item)
  end

  it 'can find_all_with_descriprion(description)' do
    test = @item_repository.find_all_by_description("vector shapes")

    expect(@item_repository.find_all_by_description("vector shapes").count).to eq(1)
    expect(@item_repository.find_all_by_description("vector shapes")).to be_a(Array)
    expect(test.map(&:description).include?("100% vector shapes (AI, CDR, SVG)")).to eq true
    expect(test.map(&:id).include?(263395237)).to eq true
  end


end
