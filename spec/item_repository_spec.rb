require 'simplecov'
SimpleCov.start

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
      it 'returns items within matching prices given a range' do

        expect(@item_repo1.find_all_by_price_in_range(700..1300)).to include(@item_repo1.all[0], @item_repo1.all[1])
        expect(@item_repo1.find_all_by_price_in_range(52300..52400)).to eq([])
      end
    end

    describe 'find_all_by_merchant_id(merchant_id)' do
      it 'returns items with matching merchant ids' do

      expect(@item_repo1.find_all_by_merchant_id(12334195)).to include(@item_repo1.all[8])
      expect(@item_repo1.find_all_by_merchant_id(603451)).to eq([])
      end
    end

    describe 'create(attributes)' do
      it 'creates a new item with given attributes' do
        new_item = {
          :id          => 1,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal(10.99,4),
          :created_at  => Time.now,
          :updated_at  => Time.now,
          :merchant_id => 2
          }
        @item_repo1.create(new_item)

        expect(@item_repo1.all.last).to be_a(Item)
        expect(@item_repo1.all.last.name).to eq(new_item[:name])
      end
    end

    describe 'update(id, attributes)' do
      it 'updates the item with given ids attributes' do

        attr = {
          name:         'Pencil',
          description:  'You can use it to write things',
          unit_price:   BigDecimal(10.99,4)
        }

        expect(@item_repo1.update(263_395_237, attr)).to eq(@item_repo1.all[0])
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
