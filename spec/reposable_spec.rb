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

  describe '#create' do
    it 'adds a new instance of the class corresponding to the current repo' do
      item_repo = ItemRepository.new
      item_repo.create({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
      })

      expect(item_repo.all[0]).to be_a Item
    end
  end
end