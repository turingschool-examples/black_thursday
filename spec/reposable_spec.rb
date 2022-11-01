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
    it 'adds a new instance corresponding to the current repo' do
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

  describe '#update' do
    it 'updates an instance with the corresponding id' do
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
      item_repo.update(1, {
        :name        => "Broken Pencil",
        :description => "You now have a smaller pencil",
        :unit_price  => BigDecimal(5.99,4)
      })

      expect(item_repo.all[0].name).to eq "Broken Pencil"
      expect(item_repo.all[0].description).to eq "You now have a smaller pencil"
      expect(item_repo.all[0].unit_price).to eq BigDecimal(5.99,4)
    end
  end

  describe '#find_by_id' do
    it 'returns either nil or an instance with matching id' do
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

      expect(item_repo.find_by_id(1)).to eq item
    end
  end

  describe '#delete' do
    it 'deletes instance with corresponding id' do
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

      expect(item_repo.all).to eq [item]
      
      item_repo.delete(1)

      expect(item_repo.all).to eq []
    end
  end

  # it 'has a method to create a new instance of a merchant with the supplied information' do
  #   merchant_repository.create("Seattle Muffins")
  #   expect(merchant_repository.all[0].id).to eq(1)
  #   expect(merchant_repository.all[0].name).to eq("Seattle Muffins")

  #   merchant_repository.create("Denver Biscuits")
  #   expect(merchant_repository.all[1].id).to eq(2)
  #   expect(merchant_repository.all[1].name).to eq("Denver Biscuits")
  # end

  # it 'has a method to update the NAME only of a merchant' do
  #   merchant_repository.create("Denver Biscuits")
  #   merchant_repository.create("Seattle Muffins")
    
  #   merchant_repository.update(2, "Seattle Super Muffins")
   
  #   expect(merchant_repository.find_by_name("Seattle Super Muffins")).to eq(merchant_repository.find_by_id(2))
  #   expect(merchant_repository.find_all_by_name("super")).to eq([merchant_repository.merchants[1]])
  # end

  # it 'has a method to delete a merchant from the list using its ID' do
  #   merchant_repository.create("Denver Biscuits")
  #   merchant_repository.create("Seattle Muffins")
    
  #   merchant_repository.delete(2)
    
  #   expect(merchant_repository.all[0]).to eq(merchant_repository.find_by_id(2))
  #   expect(merchant_repository.find_by_id(1)).to eq(nil)
  #   expect(merchant_repository.find_by_name("Denver Biscuits")).to eq(nil)
  # end
end