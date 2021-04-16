require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require 'bigdecimal/util'

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
      expect(repo.array_of_objects[0]).to be_instance_of(Item)
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

  describe 'various find methods' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })
    repo = sales_engine.items

      # it 'find_by_id returns an instance by matching id' do
      #   id = 263538760
      #
      #   expect(repo.find_by_id(id).id).to eq(id)
      #   expect(repo.find_by_id(id).name).to eq("Puppy blankie")
      # end

      # it 'find_by_id returns a nil if no id match' do
      #   id = 10
      #
      #   expect(repo.find_by_id(id)).to eq(nil)
      # end

      it 'find_by_name returns instance of item by matching name' do
        name = "Puppy blankie"

        expect(repo.find_by_name(name).name).to eq("Puppy blankie")
        expect(repo.find_by_name(name).id).to eq(263538760)
      end

      it 'find_by_name handles case insensitive search' do
        name = "puppy blankie"

        expect(repo.find_by_name(name).name).to eq("Puppy blankie")
      end

      it 'find_by_name returns nil if no name match' do
        name = "Sales Engine"

        expect(repo.find_by_name(name)).to eq(nil)
      end

      it 'find_all_with_description returns array by matching descriptions' do
        description = "A large Yeti of sorts, casually devours a cow as the others watch numbly."

        expect(repo.find_all_with_description(description)[0].description).to eq(description)
        expect(repo.find_all_with_description(description)[0].id).to eq(263550472)
      end

      it 'find_all_with_description returns empty array if no match' do
        description = "SalesEngine"

        expect(repo.find_all_with_description(description)).to eq([])
      end

      it 'find_all_with_description handles case insensitive search' do
        description = "a large yeti of sorts, casually devours a cow as the others watch numbly."

        expect(repo.find_all_with_description(description)[0].description).to eq("A large Yeti of sorts, casually devours a cow as the others watch numbly.")
      end

      it '#find_all_by_price returns array if item instances with matching price' do
        price = BigDecimal(25)

        expect(repo.find_all_by_price(price)[0].unit_price_to_dollars).to eq(price)
        expect(repo.find_all_by_price(price).length).to eq(79)
      end

      it '#find_all_by_price returns [] if no items match price' do
        price = 0

        expect(repo.find_all_by_price(price)).to eq([])
      end

      it  '#find_all_by_price_in_range returns array of items with price in range' do
        range = (1000.00..1500.00)

        expect(repo.find_all_by_price_in_range(range).length).to eq(19)
      end

      it  '#find_all_by_price_in_range returns [] if no prices in range' do
        range = (1000000.00..1500000.00)

        expect(repo.find_all_by_price_in_range(range)).to eq([])
      end

      it '#find_all_by_merchant_id returns array of items with merchant id' do
        merchant_id = 12334326

        expect(repo.find_all_by_merchant_id(merchant_id).length).to eq(6)
      end

      it '#find_all_by_merchant_id returns array of items with merchant id' do
        merchant_id = 00000000

        expect(repo.find_all_by_merchant_id(merchant_id)).to eq([])
      end
  end

  describe 'create, update, delete methods' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })
    repo = sales_engine.items

    attributes = {
                      :id          => 1,
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => "1099",
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      :merchant_id => 2
                    }
    repo.create(attributes)

    it '#create creates new instance with attribute argument' do

      expect(repo.all.count).to eq(1368)
      expect(repo.all.last).to be_an_instance_of(Item)
      expect(repo.all.last.name).to eq("Pencil")
    end

    it '#creates test for new id to be incremented by one' do
      # second_to_last_item_id = repo.all[-2].id
      # last_item_id = repo.all[-1].id
      # expected = last_item_id - second_to_last_item_id
      # expect(expected).to eq(1)
      expect(repo.all.last.id).to eq(263567475)
    end

    it 'can update existing item' do
      repo.update(263567474, attributes)
      expected = repo.find_by_id(263567474)
      expect(expected.name).to eq("Pencil")
      expect(expected.updated_at).not_to eq(expected.created_at)
    end

    it 'can delete item' do
      repo.delete(263567474)
      expected = repo.find_by_id(263567474)
      expect(expected).to eq(nil)
    end
  end
end
