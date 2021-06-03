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
    @repo.find_all_with_description('clothing').each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball glove'])

    expect(@repo.find_all_with_description('for basketball')).to eq([])
  end

  it 'returns items by price' do
    item_names = []
    @repo.find_all_by_price(10).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball bat', 'baseball glove'])

    item_names = []
    @repo.find_all_by_price(5).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball'])

    expect(@repo.find_all_by_price(20)).to eq([])
  end

  it 'returns items by price in a range' do
    item_names = []
    @repo.find_all_by_price_in_range(0..5).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball'])

    item_names = []
    @repo.find_all_by_price_in_range(0..11).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball', 'baseball bat', 'baseball glove'])

    expect(@repo.find_all_by_price_in_range(0..4)).to eq([])
  end

  xit 'returns items by merchant id' do
    item_names = []
    @repo.find_all_by_merchant_id(10).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['baseball'])

    expect(@items_repo.find_all_by_merchant_id(10)).to eq([@item1, @item3])
    expect(@items_repo.find_all_by_merchant_id(20)).to eq([@item2])
    expect(@items_repo.find_all_by_merchant_id(50)).to eq([])
  end

  xit 'creates new item instance' do
    expect(@real_repo.length).to eq(3)

    @items_repo.create({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
      }, nil)

    expect(@item_repo.all.length).to eq(4)
    expect(@items_repo.all[3].id).to eq(16)
    expect(@items_repo.all[3].name).to eq('baseball jersey')
  end

  xit 'updates item attributes by id' do
    new_attributes = {name: 'changed name', description: 'clothing', unit_price: 15}
    id = 'number from csv'
    old_time = @real_rep.find_by_id(id).updated_at

    @real_repo.update(id, new_attributes)

    expect(@real_rep.find_by_id(id).name).to eq('changed name')
    expect(@real_rep.find_by_id(id).updated_at).not_to eq(old_time)
    expect(@real_rep.all.length).to eq()
  end

  xit 'updates single item attribute by id' do
    new_attributes = {name: 'new name'}
    id = 'number from csv'
    og_price = @real_rep.find_by_id(id).price
    old_time = @real_rep.find_by_id(id).updated_at

    @real_repo.update(id, new_attributes)

    expect(@real_rep.find_by_id(id).name).to eq()
    expect(@real_rep.find_by_id(id).price).to eq(og_price)
    expect(@real_rep.find_by_id(id).updated_at).not_to eq(old_time)
    expect(@real_rep.all.length).to eq()
  end

  xit 'deletes item by id' do
    allow(@item1).to receive(:id).and_return(3)
    allow(@item2).to receive(:id).and_return(5)
    allow(@item3).to receive(:id).and_return(10)

    @items_repo.delete(5)

    expect(@items_repo.find_by_id(5)).to eq(nil)
    expect(@items_repo.all.length).to eq(2)
  end
end
