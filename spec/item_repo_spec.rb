require 'CSV'
require './lib/sales_engine'
require './lib/merchant_repo'
require './lib/merchant'
require './lib/item'
require './lib/item_repo'
require 'bigdecimal'

RSpec.describe ItemRepo do
  describe 'instantiation' do

    it '::new' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)
     
      expect(item_repo).to be_an_instance_of(ItemRepo)
    end

    it 'has attributes' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)

      expect(item_repo.items).to be_an_instance_of(Array)
    end
  end

  describe '#methods' do

    it '#all' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)

      expect(item_repo.all).to be_an_instance_of(Array)
    end

    it '#add item' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)
      item1 = Item.new({:id          => 1,
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => BigDecimal(10.99,4),
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      :merchant_id => 2}, se)
      item_repo.add_item(item1)

      expect(item_repo.items.include?(item1)).to eq true
    end

    it '#find by id' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)
      item1 = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2}, se)

      item_repo.add_item(item1)

      expect(item_repo.find_by_id(1)).to eq(item1)
      expect(item_repo.find_by_id(999999999)).to eq(nil)
    end

    it '#find by name' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)
      item1 = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2}, se)

      item_repo.add_item(item1)

      expect(item_repo.find_by_name("Pencil")).to eq(item1)
      expect(item_repo.find_by_name("not exist")).to eq(nil)
    end

    it '#find by description' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)
      item1 = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2}, se)

      item_repo.add_item(item1)

      expect(item_repo.find_all_with_description("You can use it to write things")).to eq([item1])
      expect(item_repo.find_all_with_description("not exist")).to eq([])
    end

    it '#find all by price' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)
      item1 = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2}, se)

      item_repo.add_item(item1)

      expect(item_repo.find_all_by_price(10.99)).to eq([item1])
      expect(item_repo.find_all_by_price(0)).to eq([])
    end

    it '#find all by price by range' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)
      item1 = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2}, se)

      item_repo.add_item(item1)

      expect(item_repo.find_all_by_price_in_range(10.97..10.99)).to eq([item1])
      expect(item_repo.find_all_by_price_in_range(0..0.1)).to eq([])
    end

    it '#find by merchant' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)
      item1 = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2}, se)
      item_repo.add_item(item1)

      expect(item_repo.find_all_by_merchant_id(2)).to eq([item1])
      expect(item_repo.find_all_by_merchant_id(0)).to eq([])
    end

    it '#creates item' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)
      item_info = ({:id          => 0,
                    :name        => nil,
                    :description => nil,
                    :unit_price  => BigDecimal(0),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 0 })

      item_repo.all

      expect(item_repo.create(item_info)).to be_an_instance_of(Item)
    end

    it '#update attributes' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)
      item1 = Item.new({:id          => 1,
                        :name        => "Pencil",
                        :description => "You can use it to write things",
                        :unit_price  => BigDecimal(10.99,4),
                        :created_at  => Time.now,
                        :updated_at  => Time.now,
                        :merchant_id => 2}, se)
      item_repo.add_item(item1)
      
      updated_attributes = {:name => "knife",
                            :description => "You can use it to stab things",
                            :unit_price  => BigDecimal(15.99, 4),
                            :updated_at  => Time.now}
      
      item_repo.update(1, updated_attributes)

      expect(item1.id).to eq(1)
      expect(item1.name).to eq("knife")
      expect(item1.description).to eq("You can use it to stab things")
      expect(item1.unit_price).to eq(15.99)
      expect(item1.updated_at).to be_an_instance_of(Time)
    end

    it '#delete by id' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
      
      item_repo = ItemRepo.new("./data/items.csv", se)
      item1 = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2}, se)
      
     item_repo.add_item(item1)

      expect(item_repo.find_by_id(1)).to eq(item1)

      item_repo.delete(1)
      
      expect(item_repo.find_by_id(1)).to eq(nil)
    end
  end
end
