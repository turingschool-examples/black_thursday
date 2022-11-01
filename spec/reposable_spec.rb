require './lib/reposable'
require './lib/itemrepository'
require './lib/item'

RSpec.describe Reposable do
  describe '#class_name' do
    it 'returns a const of the class the current repo is storing' do
      item = Item.new({})  
      item_repo = ItemRepository.new

      expect(item_repo.class_name).to eq Item
    end
  end
end