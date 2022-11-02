# frozen_string_literal: true
require './lib/item'
require './lib/item_repository'
require 'bigdecimal'
require 'CSV'

describe ItemRepository do
  before(:each) do
    @stats = CSV.readlines('./data/items.csv', headers: true, header_converters: :symbol)
    @stats = @stats[0..4]
    @ir = ItemRepository.new(@stats)
    @item1 = @ir.all[0]
    @item2 = @ir.all[1]
    @item3 = @ir.all[2]
    @item4 = @ir.all[3]
    @item5 = @ir.all[4]
  end

  describe '#initialization' do
    it 'exists' do
      expect(@ir).to be_instance_of(ItemRepository)
    end
  end

  describe '#create' do
    it 'creates an item based on the values passed in' do
      @ir.create(
        id:          1,
        name:        'Pencil',
        description: 'You can use it to write things',
        unit_price:  BigDecimal(10.99, 4),
        created_at:  Time.now,
        updated_at:  Time.now,
        merchant_id: 2
      )

      expect(@ir.all.last.name).to eq('Pencil')
    end
  end

  describe '#all' do
    it 'returns list of all added items' do
      expect(@ir.all).to eq([@item1, @item2, @item3, @item4, @item5])
    end
  end

  describe '#find_by_id' do
    it 'searches for specific item id and returns item or nil if empty' do
      expect(@ir.find_by_id(263395237)).to eq(@item1)
      expect(@ir.find_by_id(263395537)).to eq(nil)
    end
  end

  describe '#find_by_name' do
    it 'searches for specific name and returns item or nil' do
      expect(@ir.find_by_name('Glitter scrabble frames')).to eq(@item2)
      expect(@ir.find_by_name('Glitter scrabble')).to eq(nil)
    end
  end

  describe '#clean_string' do
    it 'returns a string after removing spaces and newline characters' do
      unclean = "Free standing wooden\n letters \n15cm Any colours\n"
      cleaned = "freestandingwoodenletters15cmanycolours"
      expect(@ir.clean_string(unclean)).to eq(cleaned)
    end
  end

  describe '#find_by_description' do
    it 'searches for specific description and returns items found or empty array' do
      description = "Free standing wooden\n letters \n15cm Any colours\n"
      expect(@ir.find_by_description(description)).to eq([@item4])
      expect(@ir.find_by_description("Free standing wooden\n letters")).to eq([])
    end
  end

  describe '#find_all_by_price' do
    it 'searches for specific price and returns items' do
      expect(@ir.find_all_by_price(1300)).to eq([@item2])
      expect(@ir.find_all_by_price(1000)).to eq([])
    end
  end

  describe '#find_all_by_price_range' do
    it 'searches for specific price range and returns items' do
      expect(@ir.find_all_by_price_range(1000..1400)).to eq([@item1, @item2, @item3])
      expect(@ir.find_all_by_price_range(10..100)).to eq([])
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'searches for merchant id and returns items' do
      expect(@ir.find_all_by_merchant_id(12334141)).to eq([@item1])
      expect(@ir.find_all_by_merchant_id(12334615)).to eq([])
    end
  end

  describe '#update' do
    it 'updates the values of the item at id with attributes passed in' do
      @ir.update(263395237, name: 'Turkey Leg')
      expect(@item1.name).to eq('Turkey Leg')
      expect(@item1.unit_price_to_dollars).to eq(1200)
    end
  end

  describe '#delete' do
    it 'deletes the item at the specified id index' do
      @ir.delete(263395237)
      expect(@ir.all).to eq([@item2, @item3, @item4, @item5])
    end
  end
end
