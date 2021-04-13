require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/item'

RSpec.describe ItemRepository do
  describe 'initialization' do
    repo = ItemRepository.new

    it 'exists' do
      expect(repo).to be_instance_of(ItemRepository)
    end

    it 'can create item objects' do
      item_data = SalesEngine.parse_csv("./data/items.csv")
      expect(repo.create_items(item_data)[0]).to be_instance_of(Item)
    end
  end
end
