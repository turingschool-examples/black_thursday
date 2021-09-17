# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'rspec'
require 'csv'
require './lib/items'
require './lib/item_repository'


describe ItemRepository do
  before(:each) do
    @item_repo1 = ItemRepository.new('./data/items.csv')
  end
  it 'exists' do

    expect(@item_repo1).to be_a ItemRepository
  end

  describe 'all' do
    it 'returns all items' do

      expect(@item_repo1.all).to be_a(Array)

      @item_repo1.all.each do |item|
        expect(item).to be_a(Item)
      end
    end
  end

  describe 'find_by_id(id)' do
    it 'returns items with matching id' do

      expect(@item_repo1.find_by_id('263395237')).to eq(@item_repo1.all[0])
      expect(@item_repo1.find_by_id('8675309')).to eq(nil)
    end
  end

  describe 'find_by_name(name)' do
    it 'returns items with matching names' do
      name1 = 'Glitter scrabble frames'
      name2 = 'Replacement Boggle Dice'
      expect(@item_repo1.find_by_name(name1)).to eq(@item_repo1.all[1])
      expect(@item_repo1.find_by_name(name2)).to eq(nil)
    end
  end

  describe 'find_all_with_descrip(description)' do
    it 'returns all items with matching descriptions' do
      description1 = 'TABLEAU'
      description2 = 'Corncob on the bread'
      item = @item_repo1.all[12]

      expect(@item_repo1.find_all_with_descrip(description1)).to include(item)
      expect(@item_repo1.find_all_with_descrip(description2)).to eq([])
    end
  end

  describe 'find_all_by_price(price)' do
    it 'returns items with matching prices' do

      expect(@item_repo1.find_all_by_price(1300)).to include(@item_repo1.all[1])
      expect(@item_repo1.find_all_by_price(72_531)).to eq([])
    end
  end

  describe 'find_all_by_price_in_range(range)' do
    it 'returns items within matching prices given a range' do

      expect(@item_repo1.find_all_by_price_in_range(700..1300)).to include(@item_repo1.all[0], @item_repo1.all[1])
      expect(@item_repo1.find_all_by_price_in_range(52_300..52_400)).to eq([])
    end
  end

  describe 'find_all_by_merchant_id(merchant_id)' do
    it 'returns items with matching merchant ids' do
      merchid1 = 123_341_95
      merchid2 = 603_451
      expect(@item_repo1.find_all_by_merchant_id(merchid1)).to include(@item_repo1.all[8])
      expect(@item_repo1.find_all_by_merchant_id(merchid2)).to eq([])
    end
  end

  describe 'create(attributes)' do
    it 'creates a new item with given attributes' do
      @item_repo1.create('Pencil', 'Use it to write things', 10.99, 4, 2)

      expect(@item_repo1.all.last).to be_a(Item)
      expect(@item_repo1.all.last.name).to eq('Pencil')
    end
  end

  describe 'update(id, attribute, value)' do
    it 'updates the item with given ids attributes' do
      id = 263_395_237
      attr = 'name'
      value = 'Pencil'

      expect(@item_repo1.update(id, attr, value)).to eq(@item_repo1.all[0])
      expect(@item_repo1.all[0].name).to eq('Pencil')
    end
  end

  describe 'delete(id)' do
    it 'deletes the item with the given id' do
      deleted_item = @item_repo1.all[0]

      expect(@item_repo1.delete(263_395_237)).to eq(deleted_item)
      expect(@item_repo1.find_by_id(263_395_237)).to be_nil
    end
  end
end
