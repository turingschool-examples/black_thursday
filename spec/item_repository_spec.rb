require './lib/item_repository'
require './lib/item'
require 'rspec'
require 'simplecov'
require 'bigdecimal'

SimpleCov.start

RSpec.describe ItemRepository do

  before :each do
    @ir = ItemRepository.new
    @i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
  end

  describe 'Object Creation' do

    it 'exists' do
      ir = ItemRepository.new

      expect(@ir).to be_a(ItemRepository)
    end

    it 'has readable attributes' do


      expect(@ir.all).to be_a(Array)
      expect(@ir.all).to eq([])

      @ir.all << @i

      expect(@ir.all).to be_a(Array)
      expect(@ir.all).to eq([@i])
    end

  end

  describe 'Object Methods' do

    before :each do
      @ir.all << @i
    end

    it 'can return Item by object ID' do
      expect(@ir.find_by_id(1)).to eq(@i)
      expect(@ir.find_by_id(2)).to eq(nil)
    end

    it 'can return Item by item name' do
      expect(@ir.find_by_name("Pencil")).to eq(@i)
      expect(@ir.find_by_name("Pen")).to eq(nil)
    end

    it 'can return all Items by item description' do
      expect(@ir.find_all_with_description("You can use it to write things")).to eq([@i])
      expect(@ir.find_all_with_description("You can eat it")).to eq([])
    end

    it 'can return all Items by price' do
      expect(@ir.find_all_by_price(BigDecimal(10.99,4))).to eq([@i])
      expect(@ir.find_all_by_price(10.99)).to eq([@i])
      expect(@ir.find_all_by_price(BigDecimal(9.99,3))).to eq([])
      expect(@ir.find_all_by_price(9.99)).to eq([])
    end

    # it 'can return all Items by price range' do
    #   expect(@ir.find_all_by_price_in_range(/[10-11]/)).to eq([@i])
    #   expect(@ir.find_all_by_price_in_range(BigDecimal(9.99,3))).to eq([])
    # end

  end

end
