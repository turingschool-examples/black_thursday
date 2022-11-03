# frozen_string_literal: true
require './lib/item'
require 'bigdecimal'

describe Item do
  before(:each) do
    @item_list = {
      id:          1,
      name:        'Pencil',
      description: 'You can use it to write things',
      unit_price:  BigDecimal(10.99, 4),
      created_at:  Time.now,
      updated_at:  Time.now,
      merchant_id: 2
    }

    @item = Item.new(@item_list)
  end

  describe '#initialization' do
    it 'exists' do
      expect(@item).to be_instance_of(Item)
    end
  end

  describe '#getters' do
    it 'returns item id' do
      expect(@item.id).to eq(1)
    end

    it 'returns item name' do
      expect(@item.name).to eq('Pencil')
    end

    it 'returns item description' do
      expect(@item.description).to eq('You can use it to write things')
    end

    it 'returns item unit price' do
      expect(@item.unit_price).to eq(BigDecimal(10.99, 4))

      @item_list[:unit_price] = 144
      @item = Item.new(@item_list)

      expect(@item.unit_price).to eq(BigDecimal(1.44, 4))

      @item_list[:unit_price] = 17000
      @item = Item.new(@item_list)

      expect(@item.unit_price).to eq(BigDecimal(170.00, 4))
    end

    it 'returns item creation date' do
      expect(@item.created_at).to be_instance_of(Time)
    end

    it 'returns item updated date' do
      expect(@item.updated_at).to be_instance_of(Time)
    end

    it 'returns item merchant id' do
      expect(@item.merchant_id).to eq(2)
    end

    it 'returns item unit price converted to money format' do
      expect(@item.unit_price_to_dollars).to eq(10.99)

      @item_list[:unit_price] = 17000
      @item = Item.new(@item_list)

      expect(@item.unit_price_to_dollars).to eq(170.0)

      @item_list[:unit_price] = 144
      @item = Item.new(@item_list)

      expect(@item.unit_price_to_dollars).to eq(1.44)
    end
  end

  describe '#update' do
    it 'Updates the attributes of an item based on passed values' do
      @item.update(name: 'Turkey Leg', unit_price: 100)
      expect(@item.name).to eq('Turkey Leg')
      expect(@item.unit_price_to_dollars).to eq(1.00)
      expect(@item.description).to eq('You can use it to write things')
    end
  end
end
