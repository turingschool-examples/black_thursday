require 'rspec'
require 'csv'
require './lib/items'
require './lib/item_repository'


describe ItemRepository do
  before(:each) do
    @item_repo1 = ItemRepository.new
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

        expect(@item_repo1.find_by_id("263395237")).to eq(@item_repo1.all[0])
        expect(@item_repo1.find_by_id('8675309')).to eq(nil)
      end
    end

    describe 'find_by_name(name)' do
      it 'returns items with matching names' do

      expect(@item_repo1.find_by_name("Glitter scrabble frames")).to eq(@item_repo1.all[1])
      expect(@item_repo1.find_by_name("Replacement Boggle Dice")).to eq(nil)
      end
    end
    describe 'find_all_with_description(description)' do
      it 'returns all items with matching descriptions' do

      expect(@item_repo1.find_all_with_description("TABLEAU")).to include(@item_repo1.all[12])
      expect(@item_repo1.find_all_with_description("Corncob on the bread")).to eq([])
      end
    end

    describe 'find_all_by_price(price)' do
      it 'returns items with matching prices' do

      expect(@item_repo1.find_all_by_price(1300)).to include(@item_repo1.all[1])
      expect(@item_repo1.find_all_by_price(72531)).to eq([])
      end
    end

    describe 'find_all_by_price_in_range(range)' do
      xit 'returns items within matching prices given a range' do
      end
    end

    describe 'find_all_by_merchant_id(merchant_id)' do
      it 'returns items with matching merchant ids' do

      expect(@item_repo1.find_all_by_merchant_id(12334195)).to include(@item_repo1.all[8])
      expect(@item_repo1.find_all_by_merchant_id(603451)).to eq([])
      end
    end

    describe 'create(attributes)' do
      xit 'creates a new item with given attributes' do
      end
    end

    describe 'update(id, attributes)' do
      xit 'updates the item with given ids attributes' do
      end
    end

    describe 'delete(id)' do
      xit 'deletes the item with the given id' do
      end
    end
  end
