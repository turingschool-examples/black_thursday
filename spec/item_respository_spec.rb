require_relative 'spec_helper'
require_relative '../lib/item_repository'

RSpec.describe ItemRepository do
  before (:each) do
    @item1 = instance_double('item1')
    @item2 = instance_double('item2')
    @item3 = instance_double('item3')
    @items = [@item1, @item2, @item3]
    @items_repo = ItemRepository.new(@items)
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
end
