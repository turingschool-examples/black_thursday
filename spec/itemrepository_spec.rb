require './lib/itemrepository'
require './lib/item'

RSpec.describe ItemRepository do
  let(:item_repository) {ItemRepository.new}

  it 'is an instance of ItemRepository' do
    expect(item_repository).to be_a ItemRepository
  end
end