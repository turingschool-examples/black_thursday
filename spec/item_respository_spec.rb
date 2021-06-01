require_relative 'spec_helper'
require_relative '../lib/item_repository'

RSpec.describe ItemRepository do
  before (:each) do
    @item1 = instance_double('item1')
    @item2 = instance_double('item2')
    @item3 = instance_double('item3')
    @items = [@item1, @item2, @item3]
    allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(@items)
    @items_repo = ItemRepository.new('path')
  end

  it 'exists' do
    expect(@items_repo).to be_a(ItemRepository)
  end

  it 'returns all' do
    expect(@items_repo.all).to eq([@item1, @item2, @item3])
  end

  it 'returns item by id number' do
    allow(@item1).to receive(:id).and_return(3)
    allow(@item2).to receive(:id).and_return(5)
    allow(@item3).to receive(:id).and_return(10)

    expect(@items_repo.find_by_id(5)).to eq(@item2)
    expect(@items_repo.find_by_id(20)).to eq(nil)
  end

  it 'returns item by name' do
    allow(@item1).to receive(:name).and_return('baseball')
    allow(@item2).to receive(:name).and_return('baseball bat')
    allow(@item3).to receive(:name).and_return('baseball glove')

    expect(@items_repo.find_by_name('baseball')).to eq(@item1)
    expect(@items_repo.find_by_name('BASEBALL BAT')).to eq(@item2)
    expect(@items_repo.find_by_name('baseball hat')).to eq(nil)
  end

  it 'returns item by description' do
    allow(@item1).to receive(:description).and_return('for baseball')
    allow(@item2).to receive(:description).and_return('for baseball')
    allow(@item3).to receive(:description).and_return('clothing')

    expect(@items_repo.find_all_with_description('for baseball')).to eq([@item1, @item2])
    expect(@items_repo.find_all_with_description('clothing')).to eq([@item3])
    expect(@items_repo.find_all_with_description('for basketball')).to eq([])
  end

  it 'returns items by price' do
    allow(@item1).to receive(:price).and_return(5)
    allow(@item2).to receive(:price).and_return(10)
    allow(@item3).to receive(:price).and_return(5)

    expect(@items_repo.find_all_by_price(5)).to eq([@item1, @item3])
    expect(@items_repo.find_all_by_price(10)).to eq([@item2])
    expect(@items_repo.find_all_by_price(20)).to eq([])
  end

  it 'returns items by price in a range' do
    allow(@item1).to receive(:price).and_return(5)
    allow(@item2).to receive(:price).and_return(7)
    allow(@item3).to receive(:price).and_return(15)

    expect(@items_repo.find_all_by_price_in_range(0..5)).to eq([@item1])
    expect(@items_repo.find_all_by_price_in_range(0..8)).to eq([@item1, @item2])
    expect(@items_repo.find_all_by_price_in_range(0..20)).to eq([@item1, @item2, @item3])
    expect(@items_repo.find_all_by_price_in_range(0..4)).to eq([])
  end

  it 'returns items by merchant id' do
    allow(@item1).to receive(:merchant_id).and_return(10)
    allow(@item2).to receive(:merchant_id).and_return(20)
    allow(@item3).to receive(:merchant_id).and_return(10)

    expect(@items_repo.merchant_id(10)).to eq([@item1, @item3])
    expect(@items_repo.merchant_id(20)).to eq([@item2])
    expect(@items_repo.merchant_id(50)).to eq([])
  end
end
