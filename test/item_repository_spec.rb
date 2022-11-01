require './test/spec_helper'
require 'bigdecimal/util'

RSpec.describe ItemRepository do
  let (:item_1) {Item.new({:id => 1,
                   :name => "Shoes",
                   :description => "left shoe, right shoe",
                   :unit_price => BigDecimal(78.54,4),
                   :created_at => Time.now,
                   :updated_at => Time.now,
                   :merchant_id => 1})}
  let (:item_2) {Item.new({:id => 2,
                    :name => "Cool hat",
                    :description => "black top hat",
                    :unit_price => BigDecimal(22.24,4),
                    :created_at => Time.now,
                    :updated_at => Time.now,
                    :merchant_id => 2})}
  let (:item_3) {Item.new({:id => 3,
                    :name => "More Expensive Cool hat",
                    :description => "black top hat",
                    :unit_price => BigDecimal(32.44,4),
                    :created_at => Time.now,
                    :updated_at => Time.now,
                    :merchant_id => 2})}
                    
  describe '#initialize item repository' do
    it 'exists' do
      items = [item_1, item_2]
      item_repository = ItemRepository.new(items)

      expect(item_repository).to be_a(ItemRepository)
    end
  end

  describe '#all' do
    it 'returns an array of all known items' do
      items = [item_1, item_2]
      item_repository = ItemRepository.new(items)

      expect(item_repository.all).to eq([item_1, item_2])
    end
  end

  describe '#find_by_id' do
    it 'returns nil or an instance of item with matching id' do
      items = [item_1, item_2]
      item_repository = ItemRepository.new(items)

      expect(item_repository.find_by_id(2)).to eq(item_2)
      expect(item_repository.find_by_id(3)).to eq(nil)
    end
  end

  describe '#find_by_name' do
    it 'returns nil or an instance of item with matching name' do
      items = [item_1, item_2]
      item_repository = ItemRepository.new(items)

      expect(item_repository.find_by_name("Cool hat")).to eq(item_2)
      expect(item_repository.find_by_id("Suit")).to eq(nil)
    end
  end

  describe '#find_all_with_description' do
    it 'returns an empty array or the instances of the item with matching description' do
      items = [item_1, item_2, item_3]
      item_repository = ItemRepository.new(items)

      expect(item_repository.find_all_with_description("black top hat")).to eq([item_2, item_3])
      expect(item_repository.find_all_with_description("BLack top Hat")).to eq([item_2, item_3])
      expect(item_repository.find_all_with_description("a really nice suit")).to eq([])
    end
  end

  describe '#find_all_by price' do
    it 'returns empty array or instances of item with matching price' do
      item_1 = Item.new({:id => 1,
                       :name => "Shoes",
                       :description => "left shoe, right shoe",
                       :unit_price => BigDecimal(78.54,4),
                       :created_at => Time.now,
                       :updated_at => Time.now,
                       :merchant_id => 1})
      item_2 = Item.new({:id => 2,
                        :name => "Cool hat",
                        :description => "black top hat",
                        :unit_price => BigDecimal(22.24,4),
                        :created_at => Time.now,
                        :updated_at => Time.now,
                        :merchant_id => 2})
      item_3 = Item.new({:id => 3,
                        :name => "More Expensive Cool hat",
                        :description => "black top hat",
                        :unit_price => BigDecimal(22.24,4),
                        :created_at => Time.now,
                        :updated_at => Time.now,
                        :merchant_id => 3})

      items = [item_1, item_2, item_3]
      item_repository = ItemRepository.new(items)

      expect(item_repository.find_all_by_price(22.24)).to eq([item_2, item_3])
      expect(item_repository.find_all_by_price(45.21)).to eq([])
    end
  end

  describe '#find_all_by price_in_range' do
    it 'returns empty array or instances of item within price range' do
      items = [item_1, item_2, item_3]
      item_repository = ItemRepository.new(items)

      expect(item_repository.find_all_by_price_in_range(15..35)).to eq([item_2, item_3])
      expect(item_repository.find_all_by_price_in_range(5..15)).to eq([])
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'returns empty array or instances of item with matching merchant id' do
      items = [item_1, item_2, item_3]
      item_repository = ItemRepository.new(items)

      expect(item_repository.find_all_by_merchant_id(2)).to eq([item_2, item_3])
      expect(item_repository.find_all_by_merchant_id(5)).to eq([])
    end
  end

  describe '#create' do
    it 'creates a new item instance with the attributes provided' do
      items = [item_1, item_2, item_3]
      item_repository = ItemRepository.new(items)
      
      expect(item_repository.all).to eq([item_1, item_2, item_3])
      item_4 = item_repository.create(:name => "Extra Cool Hat")
      
      expect(item_repository.all).to eq([item_1, item_2, item_3, item_4])
      expect(item_4.name).to eq("Extra Cool Hat")
      expect(item_4.id).to eq(4)
      expect(item_repository.find_by_id(4)).to eq(item_4)
    end
  end
  
  describe '#update' do
    it 'updates the attributes of a specific item with the given change' do
      items = [item_1, item_2, item_3]
      item_repository = ItemRepository.new(items)
      
      item_repository.update(1, {:id => 1, :name => "Sneakers"})
      expect(item_repository.find_by_id(1).name).to eq("Sneakers")
      
      item_repository.update(1, {:id => 1, :description => "shoes"})
      expect(item_repository.find_by_id(1).description).to eq("shoes")
      
      # item_repository.update(1, {:id => 1, :unit_price => "Sneakers"})
      # expect(item_repository.find_by_id(1).unit_price).to eq("Sneakers")
    end
  end

  describe '#delete' do
    it 'deletes a specific item from the repository' do
      items = [item_1, item_2, item_3]
      item_repository = ItemRepository.new(items)
  
      item_repository.delete(1)
      
      expect(item_repository.all).to eq([item_2, item_3])
      expect(item_repository.all.include?(item_1)).to eq(false)
    end
  end
  
end
