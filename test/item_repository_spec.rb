require './lib/item_repository'
require './lib/item'
require 'bigdecimal/util'

RSpec.describe ItemRepository do
  describe '#initialize item repository' do
    it 'exists' do
      item_1 = Item.new({:id => 1,
                       :name => "Shoes",
                       :description => "left shoe, right shoe" ,
                       :unit_price => BigDecimal(78.54,4),
                       :created_at => Time.now,
                       :updated_at => Time.now,
                       :merchant_id => 1})
      item_2 = Item.new({:id => 2,
                        :name => "Cool hat",
                        :description => "black top hat" ,
                        :unit_price => BigDecimal(22.24,4),
                        :created_at => Time.now,
                        :updated_at => Time.now,
                        :merchant_id => 2})

      items = [item_1, item_2]
      item_repository = ItemRepository.new(items)

      expect(item_repository).to be_a(ItemRepository)
    end
  end

  describe '#all' do
    it 'returns an array of all known items' do
      item_1 = Item.new({:id => 1,
                       :name => "Shoes",
                       :description => "left shoe, right shoe" ,
                       :unit_price => BigDecimal(78.54,4),
                       :created_at => Time.now,
                       :updated_at => Time.now,
                       :merchant_id => 1})
      item_2 = Item.new({:id => 2,
                        :name => "Cool hat",
                        :description => "black top hat" ,
                        :unit_price => BigDecimal(22.24,4),
                        :created_at => Time.now,
                        :updated_at => Time.now,
                        :merchant_id => 2})

      items = [item_1, item_2]
      item_repository = ItemRepository.new(items)

      expect(item_repository.all).to eq([item_1, item_2])
    end
  end

  describe '#find_all_by_id' do
    it 'returns nil or an instance of item with matching id' do
      item_1 = Item.new({:id => 1,
                       :name => "Shoes",
                       :description => "left shoe, right shoe" ,
                       :unit_price => BigDecimal(78.54,4),
                       :created_at => Time.now,
                       :updated_at => Time.now,
                       :merchant_id => 1})
      item_2 = Item.new({:id => 2,
                        :name => "Cool hat",
                        :description => "black top hat" ,
                        :unit_price => BigDecimal(22.24,4),
                        :created_at => Time.now,
                        :updated_at => Time.now,
                        :merchant_id => 2})

      items = [item_1, item_2]
      item_repository = ItemRepository.new(items)

      expect(item_repository.find_by_id(2)).to eq(item_2)
      expect(item_repository.find_by_id(3)).to eq(nil)
    end
  end

end
