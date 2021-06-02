require 'CSV'
require './lib/item_repository'
require './lib/item'
require 'rspec'
require 'simplecov'
require 'bigdecimal'

SimpleCov.start

RSpec.describe ItemRepository do

  before :each do
    @ir = ItemRepository.new("./spec/fixtures/items.csv")
    # @i = Item.new({
    #   :id          => 1,
    #   :name        => "Pencil",
    #   :description => "You can use it to write things",
    #   :unit_price  => BigDecimal(10.99,4),
    #   :created_at  => Time.now,
    #   :updated_at  => Time.now,
    #   :merchant_id => 2
    # })
  end

  describe 'Object Creation' do

    it 'exists' do
      expect(@ir).to be_a(ItemRepository)
    end

    it 'has readable attributes' do
      expect(@ir.all).to be_a(Array)
      expect(@ir.all.count).to eq(6)
    end
  end

  describe 'Object Methods' do

    # before :each do
    #   @ir.all << @i
    # end

    it 'can return Item by object ID' do
      expect(@ir.find_by_id(263395237).name).to eq("RealPush Icon Set")
      expect(@ir.find_by_id(2)).to eq(nil)
    end

    it 'can return Item by item name' do
      expect(@ir.find_by_name("PeNcil").id).to eq(263396013)
      expect(@ir.find_by_name("Pen")).to eq(nil)
    end

    it 'can return all Items by item description' do
      item = @ir.find_all_with_description("Disney gliTter frames wooden")
      expect(item[0].id).to eq(263395721)
      expect(@ir.find_all_with_description("You can eat it")).to eq([])
    end

    it 'can return all Items by price' do
      item = @ir.find_all_by_price(1200)
      expect(item[0].id).to eq(263395237)
      expect(@ir.find_all_by_price(9.99)).to eq([])
    end

    it 'can return all Items by price range' do
      item = @ir.find_all_by_price_in_range(1150..1250)
      expect(item[0].id).to eq(263395237)
      expect(@ir.find_all_by_price_in_range(1..10)).to eq([])
    end

    it 'can return all Items by merchant id' do
      item = @ir.find_all_by_merchant_id(12334141)
      expect(item[0].id).to eq(263395237)
      expect(@ir.find_all_by_merchant_id(1)).to eq([])
    end

    it 'can create a new Item instance' do
      attributes = {
        :name        => "Pen",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(0.99,3),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 3
      }

      @ir.create(attributes)
      i2 = @ir.all.last

      expect(@ir.all.count).to eq(7)
      expect(i2.id).to eq(263396256)
      expect(i2).to be_a(Item)
      expect(i2.name).to eq("Pen")
      expect(i2.description).to eq("You can use it to write things")
      expect(i2.unit_price).to eq(0.99)
      expect(i2.created_at).to be_a(Time)
      expect(i2.updated_at).to be_a(Time)
      expect(i2.merchant_id).to eq(3)
    end

    it 'can update Item instance with provided attributes' do
      attributes = {
        name: "Mechanical Pencil",
        description: "You can use it to write things and refill it with lead",
        unit_price: BigDecimal(1.99,3)
      }

      @ir.update(263396013, attributes)
      item = @ir.find_by_id(263396013)
      expect(item.id).to eq(263396013)
      expect(item.merchant_id).to eq(12334185)
      expect(item.name).to eq("Mechanical Pencil")
      expect(item.description).to eq("You can use it to write things and refill it with lead")
      expect(item.unit_price).to eq(1.99)
    end

    it 'can delete Item instance by id' do
      expect(@ir.all.count).to eq(6)
      @ir.delete(263395237)
      expect(@ir.all.count).to eq(5)
    end

    it 'populates repository' do
      path = "./spec/fixtures/items.csv"
      @ir.populate_repository(path)
      @ir.delete(1)

      expect(@ir.all.count).to eq(12)
    end
  end
end
