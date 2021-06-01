require_relative 'spec_helper'
require_relative '../lib/item_repository'

RSpec.describe ItemRepository do
  before (:each) do
    @items = []
    @items_repo = ItemRepository.new(@items)
  end

  it 'exists' do
    expect(@items_repo).to be_a(ItemRepository)
  end
end
