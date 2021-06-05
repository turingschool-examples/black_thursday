require_relative 'spec_helper'
require_relative '../lib/item_repository'
require_relative '../lib/item'

RSpec.describe ItemRepository do
  before (:each) do
    @repo = ItemRepository.new('./spec/fixtures/mock_items.csv')
  end

  it 'exists' do
    expect(@repo).to be_a(ItemRepository)
  end

  it 'returns all' do
    expect(@repo.all.length).to eq(3)
    @repo.all.each do |item|
      expect(item).to be_a(Item)
    end
  end

  it 'returns item by id number' do
    expect(@repo.find_by_id(3).name).to eq('baseball')
    expect(@repo.find_by_id(5).name).to eq('baseball bat')
    expect(@repo.find_by_id(20)).to eq(nil)
  end

  it 'returns item by name' do
    expect(@repo.find_by_name('baseball glove').id).to eq(10)
    expect(@repo.find_by_name('BASEBALL BAT').id).to eq(5)
    expect(@repo.find_by_name('baseball hat')).to eq(nil)
  end

  it 'returns item by description' do
    item_names = []
    @repo.find_all_with_description('for baseball').each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball', 'baseball bat'])

    item_names = []
    @repo.find_all_with_description('clOTHing').each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball glove'])

    expect(@repo.find_all_with_description('for basketball')).to eq([])
  end

  it 'returns items by price' do
    item_names = []
    @repo.find_all_by_price(0.1e2).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball bat', 'baseball glove'])

    item_names = []
    @repo.find_all_by_price(0.5e1).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball'])

    expect(@repo.find_all_by_price(0.2e0)).to eq([])
  end

  it 'returns items by price in a range' do
    item_names = []
    @repo.find_all_by_price_in_range(0.0..0.5e1).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball'])

    item_names = []
    @repo.find_all_by_price_in_range(0.0..0.11e2).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball', 'baseball bat', 'baseball glove'])

    expect(@repo.find_all_by_price_in_range(0.0..0.4e1)).to eq([])
  end

  it 'returns items by merchant id' do
    item_names = []
    @repo.find_all_by_merchant_id(20).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball bat'])

    item_names = []
    @repo.find_all_by_merchant_id(10).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball', 'baseball glove'])

    expect(@repo.find_all_by_merchant_id(50)).to eq([])
  end

  it 'creates new id number' do
    expect(@repo.new_item_id_number).to eq(11)
  end

  it 'creates new item instance' do
    attributes = {
      :name        => 'jersey',
      :description => 'clothing',
      :unit_price  => 20,
      }
    @repo.create(attributes)

    expect(@repo.all.length).to eq(4)
    expect(@repo.find_by_id(11).name).to eq('jersey')
    expect(@repo.find_by_id(11).description).to eq('clothing')
    expect(@repo.find_by_id(11).unit_price).to eq(0.2e0)
  end

  it 'updates item attributes by id' do
    new_attributes = {
      name: 'metal bat',
      description: 'for practice',
      unit_price: BigDecimal(20, 4)
    }
    require "pry"; binding.pry
    og_time = @repo.find_by_id(5).updated_at
    @repo.update(5, new_attributes)

    expect(@repo.find_by_id(5).name).to eq('metal bat')
    expect(@repo.find_by_id(5).description).to eq('for practice')
    expect(@repo.find_by_id(5).unit_price).to eq(0.2e2)
    expect(@repo.find_by_id(5).updated_at).to_not eq(og_time)
  end

  it 'deletes item by id' do
    @repo.delete(5)

    expect(@repo.all.length).to eq(2)
    expect(@repo.find_by_id(5)).to eq(nil)
  end

  it 'can access item unit price to dollars method' do
    dollars = @repo.find_by_id(3).unit_price_to_dollars
    expect(dollars).to eq(5)
  end
end
