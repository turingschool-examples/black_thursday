require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require 'bigdecimal/util'

RSpec.describe ItemRepository do
  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                                          :items     => "./data/items.csv",
                                          :merchants => "./data/merchants.csv",
                                          :invoices => "./data/invoices.csv",
                                          :customers => "./data/customers.csv",
                                          :invoice_items => "./data/invoice_items.csv",
                                          :transactions => "./data/transactions.csv"
                                          })
    item_repo = sales_engine.items

    it 'exists' do
      expect(item_repo).to be_instance_of(ItemRepository)
    end

    it 'can create item objects' do
      expect(item_repo.array_of_objects[0]).to be_instance_of(Item)
    end
  end

#REPEATED IN REPOSITORY TESTS
  describe 'all method' do
    sales_engine = SalesEngine.from_csv({
                                          :items     => "./data/items.csv",
                                          :merchants => "./data/merchants.csv",
                                          :invoices => "./data/invoices.csv",
                                          :customers => "./data/customers.csv",
                                          :invoice_items => "./data/invoice_items.csv",
                                          :transactions => "./data/transactions.csv"
                                          })
    item_repo = sales_engine.items

      it 'returns array of all items' do
        expect(item_repo.all.count).to eq(1367)
      end
  end

  describe 'various find methods' do
    sales_engine = SalesEngine.from_csv({
                                          :items     => "./data/items.csv",
                                          :merchants => "./data/merchants.csv",
                                          :invoices => "./data/invoices.csv",
                                          :customers => "./data/customers.csv",
                                          :invoice_items => "./data/invoice_items.csv",
                                          :transactions => "./data/transactions.csv"
                                          })
    item_repo = sales_engine.items

#REPEATED IN REPOSITORY TESTS
      it 'find_by_id returns an instance by matching id' do
        id = 263538760

        expect(item_repo.find_by_id(id).id).to eq(id)
        expect(item_repo.find_by_id(id).name).to eq("Puppy blankie")
      end

#REPEATED IN REPOSITORY TESTS
      it 'find_by_id returns a nil if no id match' do
        id = 10

        expect(item_repo.find_by_id(id)).to eq(nil)
      end

      it 'find_by_name returns instance of item by matching name' do
        name = "Puppy blankie"

        expect(item_repo.find_by_name(name).name).to eq("Puppy blankie")
        expect(item_repo.find_by_name(name).id).to eq(263538760)
      end

      it 'find_by_name handles case insensitive search' do
        name = "puppy blankie"

        expect(item_repo.find_by_name(name).name).to eq("Puppy blankie")
      end

      it 'find_by_name returns nil if no name match' do
        name = "Sales Engine"

        expect(item_repo.find_by_name(name)).to eq(nil)
      end

      it 'find_all_with_description returns array by matching descriptions' do
        description = "A large Yeti of sorts, casually devours a cow as the others watch numbly."

        expect(item_repo.find_all_with_description(description)[0].description).to eq(description)
        expect(item_repo.find_all_with_description(description)[0].id).to eq(263550472)
      end

      it 'find_all_with_description returns empty array if no match' do
        description = "SalesEngine"

        expect(item_repo.find_all_with_description(description)).to eq([])
      end

      it 'find_all_with_description handles case insensitive search' do
        description = "a large yeti of sorts, casually devours a cow as the others watch numbly."

        expect(item_repo.find_all_with_description(description)[0].description).to eq("A large Yeti of sorts, casually devours a cow as the others watch numbly.")
      end

      it '#find_all_by_price returns array if item instances with matching price' do
        price = BigDecimal(25)

        expect(item_repo.find_all_by_price(price)[0].unit_price_to_dollars).to eq(price)
        expect(item_repo.find_all_by_price(price).length).to eq(79)
      end

      it '#find_all_by_price returns [] if no items match price' do
        price = 0

        expect(item_repo.find_all_by_price(price)).to eq([])
      end

      it  '#find_all_by_price_in_range returns array of items with price in range' do
        range = (1000.00..1500.00)

        expect(item_repo.find_all_by_price_in_range(range).length).to eq(19)
      end

      it  '#find_all_by_price_in_range returns [] if no prices in range' do
        range = (1000000.00..1500000.00)

        expect(item_repo.find_all_by_price_in_range(range)).to eq([])
      end

      it '#find_all_by_merchant_id returns array of items with merchant id' do
        merchant_id = 12334326

        expect(item_repo.find_all_by_merchant_id(merchant_id).length).to eq(6)
      end

      it '#find_all_by_merchant_id returns array of items with merchant id' do
        merchant_id = 00000000

        expect(item_repo.find_all_by_merchant_id(merchant_id)).to eq([])
      end
  end

  describe 'create, update, delete methods' do
    sales_engine = SalesEngine.from_csv({
                                          :items     => "./data/items.csv",
                                          :merchants => "./data/merchants.csv",
                                          :invoices => "./data/invoices.csv",
                                          :customers => "./data/customers.csv",
                                          :invoice_items => "./data/invoice_items.csv",
                                          :transactions => "./data/transactions.csv"
                                          })
    item_repo = sales_engine.items

    attributes = {
                      :id          => 1,
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => "1099",
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      :merchant_id => 2
                    }
    item_repo.create(attributes, Item)

    it '#create creates new instance with attribute argument' do

      expect(item_repo.all.count).to eq(1368)
      expect(item_repo.all.last).to be_an_instance_of(Item)
      expect(item_repo.all.last.name).to eq("Pencil")
    end

    it '#creates test for new id to be incremented by one' do
      expect(item_repo.all.last.id).to eq(263567475)
    end

    it 'can update existing item' do
      item_repo.update(263567474, attributes)
      expected = item_repo.find_by_id(263567474)
      expect(expected.name).to eq("Pencil")
      expect(expected.updated_at).not_to eq(expected.created_at)
    end

    it 'can delete item' do
      item_repo.delete(263567474)
      expected = item_repo.find_by_id(263567474)
      expect(expected).to eq(nil)
    end
  end
end
