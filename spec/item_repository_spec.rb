require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/item'

RSpec.describe ItemRepository do
  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })
    repo = sales_engine.items

    it 'exists' do
      expect(repo).to be_instance_of(ItemRepository)
    end

    it 'can create item objects' do
      item_data = SalesEngine.parse_csv("./data/items.csv")
      expect(repo.create_items(item_data)[0]).to be_instance_of(Item)
    end
  end

  describe 'all method' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })
    repo = sales_engine.items

      it 'returns array of all items' do
        expect(repo.all.count).to eq(1367)
      end
  end
end
