require_relative 'spec_helper'
require_relative '../lib/item_respository'

Rspec.describe ItemRespository do
  before (:each) do
    @items = double('item.csv')
    @items_repo = ItemRespository.new(@items)
  end

  it 'exists' do
    expect(@items_repo).to be_a(ItemRespository)
  end
end
