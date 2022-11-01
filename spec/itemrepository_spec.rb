require './lib/itemrepository'
require './lib/item'

RSpec.describe ItemRepository do
  let(:item_repo) {ItemRepository.new}

  it 'exists' do
    expect(item_repo).to be_a ItemRepository
  end

  describe '#find_by_name' do
    it 'returns either nil or an instance of Item' do
      expect(item_repo.find_by_name("Pencil")).to be nil

      item = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
      })
      item_repo = ItemRepository.new([item])

      expect(item_repo.find_by_name("Pencil")).to eq item
    end
  end

  describe '#find_all_with_description' do
    it 'returns an array of all items involving description' do
      expect(item_repo.find_all_with_description("write")).to eq []

      item1 = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
      })
      item2 = Item.new({
        :id          => 2,
        :name        => "Eraser",
        :description => "You can use it to erase things",
        :unit_price  => BigDecimal(3.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
      })
      item3 = Item.new({
        :id          => 3,
        :name        => "Pen",
        :description => "You can write but not erase",
        :unit_price  => BigDecimal(20.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
      })
      item_repo = ItemRepository.new([item1,item2,item3])
      
      expect(item_repo.find_all_with_description("write")).to eq [item1,item3]
    end
  end
end