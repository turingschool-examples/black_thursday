require 'CSV'
require './lib/item'
require 'BigDecimal'
require 'pry'


RSpec.describe Item do
  before :each do
    @x = Time.now
    @item = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal(10.99,4),
  :created_at  => @x,
  :updated_at  => @x,
  :merchant_id => 2
})
end

  it 'exists and has attributes' do
    expect(@item).to be_a Item
    expect(@item.id).to eq(1)
    expect(@item.name).to eq "Pencil"
    expect(@item.description).to eq "You can use it to write things"
    expect(@item.unit_price).to eq BigDecimal(10.99,4)
    expect(@item.created_at).to be_a Time
    expect(@item.updated_at).to be_a Time
    expect(@item.merchant_id).to eq 2
    #binding.pry
    expect(@item.created_at).to eq @x
    expect(@item.updated_at).to eq @x #come back to this
  end

  it 'has unit price to dollars' do
    expect(@item.unit_price_to_dollars).to eq 10.99
  end
end
