require "./lib/item_repository"

RSpec.describe ItemRepository do
  before :each do
    @item_repository = ItemRepository.new("./data/items.csv")
  end

  it 'exists' do
    expect(@item_repository).to be_a(ItemRepository)
  end

  it 'returns an array of all known Item instances' do
    expect(@item_repository.all).to be_a(Array)
  end

  it 'finds by id, returns nil otherwise' do
    expect(@item_repository.find_by_id(263395237)).to eq(@item_repository.all.first)
    expect(@item_repository.find_by_id(263567474)).to eq(@item_repository.all.last)
    expect(@item_repository.find_by_id(263395617)).to eq(@item_repository.all[1])
    expect(@item_repository.find_by_id(999999999)).to eq(nil)
    expect(@item_repository.find_by_id(263395237)).to be_a(Item)
  end

  it 'finds by name (case insensitive), returns nil otherwise' do
    expect(@item_repository.find_by_name("510+ RealPush Icon Set")).to eq(@item_repository.all.first)
    expect(@item_repository.find_by_name("510+ reAlPUSh IcoN seT")).to eq(@item_repository.all.first)
    expect(@item_repository.find_by_name("Glitter scrabble frames")).to eq(@item_repository.all[1])
    expect(@item_repository.find_by_name("GLITter SCRAbbLe fraMES")).to eq(@item_repository.all[1])
    expect(@item_repository.find_by_name("XXXXXXXXXX")).to eq(nil)
    expect(@item_repository.find_by_name("510+ RealPush Icon Set")).to be_a(Item)
  end

  it 'finds all instances given a description (case insensitive), returns empty array otherwise' do
    item1 = @item_repository.find_all_with_description("Disney")
    item2 = @item_repository.find_all_with_description("diSNeY")

    expect(item1.count).to eq(5)
    expect(item2.count).to eq(5)
    expect(item1.first.id).to eq(263395721)
    expect(item2.first.id).to eq(263395721)
    expect(item1).to be_a(Array)
    expect(item2).to be_a(Array)
  end

  it 'finds items with exact price given, returns empty array otherwise' do
    item1 = @item_repository.find_all_by_price(1300)
    item2 = @item_repository.find_all_by_price(1350)
    item3 = @item_repository.find_all_by_price(9999)

    expect(item1.count).to eq(8)
    expect(item2.first.id).to eq(263395617)
    expect(item3).to eq([])
    expect(item1).to be_a(Array)
  end

  it 'finds item within a given price range, returns empty array otherwise' do
    item1 = @item_repository.find_all_by_price_in_range(1300..1360)
    item2 = @item_repository.find_all_by_price_in_range(1..5)

    expect(item1.count).to eq(9)
    expect(item1.first.id).to eq(263395617)
    expect(item1.last.id).to eq(263395721)
    expect(item2).to eq([])
    expect(item1).to be_a(Array)
  end

  it 'finds item with matching merchant ID, returns empty array otherwise' do
    item1 = @item_repository.find_all_by_merchant_id(12334105)
    item2 = @item_repository.find_all_by_merchant_id(11111111)

    expect(item1.count).to eq(3)
    expect(item1.first.id).to eq(263396209)
    expect(item2).to eq([])
    expect(item1).to be_a(Array)
  end
end