require './lib/reposable'
require './lib/itemrepository'

RSpec.describe Reposable do
  describe '#class_name' do
    it 'returns the name of the class the current repo is storing' do
      item_repo = ItemRepository.new
      expect(item_repo.class_name).to eq Item
    end
  end
end