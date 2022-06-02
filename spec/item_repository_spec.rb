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


end
