require 'rspec'
require './lib/item'
require './lib/item_repository'
require 'bigdecimal'

describe 'itemrepository' do
  describe '#initialize' do
    it 'is an instance of ItemRepository' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      expect(ir).to be_an_instance_of ItemRepository
    end
  end

  describe '#all' do
    it 'returns an array of all item instances' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      expect(ir.all).to be_an Array
    end
  end

  describe '#find_by_id' do
    it 'returns an instance of Item matching the id' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      expect(ir.find_by_id(263395617)).to be_an_instance_of Item
      expect(ir.find_by_id(263395617).id).to eq(263395617)
      expect(ir.find_by_id(263395617).name).to eq("Glitter scrabble frames")
      expect(ir.find_by_id(1253467890)).to eq(nil)
    end
  end

  describe '#find_by_name' do
    it 'returns an instance of Item matching the name' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      expect(ir.find_by_name("JSK Chai")).to be_an_instance_of Item
      expect(ir.find_by_name("JSK Chai").id).to eq(263549122)
      expect(ir.find_by_name("JSK Chai").name).to eq("JSK Chai")
      expect(ir.find_by_name("This Is Not A Name")).to eq(nil)
    end
  end

  describe '#find_all_with_description' do
    it 'returns all instances of Item matching the description' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      example_description = "Free standing wooden letters \n\n15cm\n\nAny colours"

      expect(ir.find_all_with_description(example_description)).to be_an Array
      expect(ir.find_all_with_description(example_description)[0].id).to eq(263396013)
      expect(ir.find_all_with_description(example_description)[0].name).to eq("Free standing Woden letters")
      expect(ir.find_all_with_description("This Is Not A Description")).to eq([])
    end
  end

  describe '#find_all_by_price' do
    it 'returns all instances of Item matching the price' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      expect(ir.find_all_by_price(1300)).to be_an Array
      expect(ir.find_all_by_price(BigDecimal(1300) / 100)[0].id).to eq(263395617)
      expect(ir.find_all_by_price(BigDecimal(1300) / 100)[0].name).to eq("Glitter scrabble frames")
      expect(ir.find_all_by_price(981762349871234)).to eq([])
    end
  end

  describe '#find_all_by_price_in_range' do
    it 'returns all instances of Item in the price range' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      expect(ir.find_all_by_price_in_range(1000.00..1500.00).length).to eq 19
      expect(ir.find_all_by_price_in_range(1000.00..1500.00)).to be_an Array
      expect(ir.find_all_by_price_in_range(10.00..150.00).length).to eq 910
      expect(ir.find_all_by_price_in_range(10.00..15.00).length).to eq 205
      expect(ir.find_all_by_price_in_range(98176234..1000000000)).to eq([])
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'returns all instances of Item matching the merchant_id' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      expect(ir.find_all_by_merchant_id(12334261)).to be_an Array
      expect(ir.find_all_by_merchant_id(12334261)[0].id).to eq(263410631)
      expect(ir.find_all_by_merchant_id(12334261)[0].name).to eq("OLIVE SOAP")
      expect(ir.find_all_by_merchant_id(981762349871234)).to eq([])
    end
  end

  describe '#create' do
    it 'creates a new instance of Item' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      attributes = {
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => 1099,
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
      }

      expect(ir.create(attributes).last.name).to eq("Pencil")
      expect(ir.create(attributes).last.description).to eq("You can use it to write things")
    end
  end

  describe '#update' do
    it 'updates some of in Items values' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      attributes = {
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => 1099,
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
      }

      ir.update(263395617, attributes)
      expect(ir.find_by_id(263395617).name).to eq("Pencil")
      expect(ir.find_by_id(263395617).description).to eq("You can use it to write things")
      expect(ir.find_by_id(263395617).unit_price).to eq(1099)
    end
  end

  describe '#delete' do
    it 'deletes an instance of Item' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)
      ir.delete(263395617)
      expect(ir.find_by_id(263395617)).to eq(nil)
    end
  end
end
