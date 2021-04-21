require 'CSV'
require 'bigdecimal'
require 'sales_engine'

RSpec.describe ItemRepo do
  describe 'instantiation' do
    it '::new' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)

      expect(item_repo).to be_an_instance_of(ItemRepo)
    end

    it 'has attributes' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)

      expect(item_repo.items).to be_an_instance_of(Array)
    end
  end

  describe '#methods' do
    it '#all' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)

      expect(item_repo.all).to be_an_instance_of(Array)
    end

    it '#find by id' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = item_repo.items
      item = item_repo.create({:id          => 1,
                               :name        => "Pencil",
                               :description => "You can use it to write things",
                               :unit_price  => 1099,
                               :created_at  => Time.now,
                               :updated_at  => Time.now,
                               :merchant_id => 2})

      #PASSING IN THE COLLECTION (NOT IDENTICAL TO SPEC)
      expect(item_repo.find_by_id(item.id, collection)).to eq(item)
      expect(item_repo.find_by_id(999999999, collection)).to eq(nil)
    end

    it '#find by name' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = item_repo.items
      item = item_repo.create({:id          => 1,
                               :name        => "Pencil",
                               :description => "You can use it to write things",
                               :unit_price  => 1099,
                               :created_at  => Time.now,
                               :updated_at  => Time.now,
                               :merchant_id => 2})

      expect(item_repo.find_by_name("Pencil", collection)).to eq(item)
      expect(item_repo.find_by_name("not exist", collection)).to eq(nil)
    end

    it '#find by description' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = item_repo.items
      item = item_repo.create({:id          => 1,
                              :name        => "Pencil",
                              :description => "You can use it to write things",
                              :unit_price  => 1099,
                              :created_at  => Time.now,
                              :updated_at  => Time.now,
                              :merchant_id => 2})

      expect(item_repo.find_all_with_description("You can use it to write things", collection)).to eq([item])
      expect(item_repo.find_all_with_description("not exist", collection)).to eq([])
    end

    it '#find all by price' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = item_repo.items
      item = item_repo.create({:id          => 1,
                               :name        => "Pencil",
                               :description => "You can use it to write things",
                               :unit_price  => 1099,
                               :created_at  => Time.now,
                               :updated_at  => Time.now,
                               :merchant_id => 2})

      expect(item_repo.find_all_by_price(10.99, collection)).to eq([item])
      expect(item_repo.find_all_by_price(0, collection)).to eq([])
    end

    it '#find all by price by range' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = item_repo.items
      item = item_repo.create({:id          => 1,
                              :name        => "Pencil",
                              :description => "You can use it to write things",
                              :unit_price  => 1099,
                              :created_at  => Time.now,
                              :updated_at  => Time.now,
                              :merchant_id => 2})

      expect(item_repo.find_all_by_price_in_range(10.97..10.99, collection)).to eq([item])
      expect(item_repo.find_all_by_price_in_range(0..0.1, collection)).to eq([])
    end

    it '#find by merchant id' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = item_repo.items
      item = item_repo.create({:id          => 1,
                              :name        => "Pencil",
                              :description => "You can use it to write things",
                              :unit_price  => 1099,
                              :created_at  => Time.now,
                              :updated_at  => Time.now,
                              :merchant_id => 2})

      expect(item_repo.find_all_by_merchant_id(2, collection)).to eq([item])
      expect(item_repo.find_all_by_merchant_id(0, collection)).to eq([])
    end

   it'#creates item' do
    mock_engine = double('ItemRepo')
    item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)
    item = item_repo.create({:id          => 1,
                             :name        => "Pencil",
                             :description => "You can use xitto write things",
                             :unit_price  => 1099,
                             :created_at  => Time.now,
                             :updated_at  => Time.now,
                             :merchant_id => 2})

      expect(item).to be_an_instance_of(Item)
    end

   it'#update attributes' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)
      item = item_repo.create({:id          => 1,
                             :name        => "Pencil",
                             :description => "You can use xitto write things",
                             :unit_price  => 1099,
                             :created_at  => Time.now,
                             :updated_at  => Time.now,
                             :merchant_id => 2})

      updated_attributes = {:name => "knife",
                            :description => "You can use xitto stab things",
                            :unit_price  => BigDecimal(15.99, 4),
                            :updated_at  => Time.now}

      item_repo.update(item.id, updated_attributes)

      expect(item.id).to eq(263567475)
      expect(item.name).to eq("knife")
      expect(item.description).to eq("You can use xitto stab things")
      expect(item.unit_price).to eq(15.99)
      expect(item.updated_at).to be_an_instance_of(Time)
    end

   it'#delete by id' do
     mock_engine = double('ItemRepo')
    item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)
    item = item_repo.create({:id        => 1,
                             :name        => "Pencil",
                             :description => "You can use it to write things",
                             :unit_price  => 1099,
                             :created_at  => Time.now,
                             :updated_at  => Time.now,
                             :merchant_id => 2})

      expect(item_repo.find_by_id(item.id)).to eq(item)

      item_repo.delete(item.id)

      expect(item_repo.find_by_id(item.id)).to eq(nil)
   end

    it '#average price' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)

      expect(item_repo.average_price).to be_a(Float)
    end

    it'#item count per merchant' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)

      expect(item_repo.item_count_per_merchant).to be_a(Hash)
    end

    it '#average_item_price_standard_deviation' do
      mock_engine = double('ItemRepo')
      item_repo = ItemRepo.new('./fixtures/mock_items.csv', mock_engine)

      expect(item_repo.average_item_price_standard_deviation).to eq(2899.93)
    end
  end
end
