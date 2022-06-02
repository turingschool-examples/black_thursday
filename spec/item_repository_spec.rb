require'./lib/item'
require'./item_repository'

RSpec.describe ItemRepository do
  before :each do
    @item_repository = ItemRepository.new("./data/items.csv")
  end

  it 'exists' do
    expect(@item_repository).to be_a ItemRepository
  end


end
