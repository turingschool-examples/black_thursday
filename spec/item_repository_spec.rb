require "Rspec"
require "./lib/item_repository"

describe ItemRepository do
  before :each do
    @ir = ItemRepository.new('./data/items.csv')
  end

  it 'is an instance of ItemRepository' do
    expect(@ir).to be_a ItemRepository
  end
end