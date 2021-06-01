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
end
