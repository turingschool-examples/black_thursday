require_relative './spec_helper'
require 'BigDecimal'

RSpec.describe Item do
  let!(:item) {Item.new({
    :id          => 1,
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 2
  })}

  it 'is an instace of item' do
    expect(item).to be_instance_of Item
  end

  it 'has an id' do
    expect(item.id).to eq(1)
  end

  it 'has a name' do
    expect(item.name).to eq("Pencil")
  end

  it 'has a description' do
    expect(item.description).to eq("You can use it to write things")
  end

  it 'has a unit price' do
    expect(item.unit_price).to eq(BigDecimal(10.99,4))
  end

  it 'has a date for when it was created' do
    expect(item.created_at).to be_instance_of(Time)
  end

  it 'has a date for when it was last modified' do
    expect(item.updated_at).to be_instance_of(Time)
  end

  it 'has a merchant id' do
    expect(item.merchant_id).to eq(2)
  end

  it 'returns toe price of the item in dollars' do
    expect(item.unit_price_to_dollars).to eq(10.99)
  end

end
