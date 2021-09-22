require_relative 'spec_helper'
require 'Rspec'
require 'bigdecimal'
require_relative '../lib/item'

describe Item do
  before :each do
    @i = Item.new({
      :id          => '1',
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => '10.99',
      :created_at  => '2016-01-11 09:34:06 UTC',
      :updated_at  => '2007-06-04 21:35:10 UTC',
      :merchant_id => '2'
    })
  end

  it 'is an item' do
    expect(@i).to be_a Item
  end

  it '#id' do
    expect(@i.id).to eq 1
  end

  it '#name' do
    expect(@i.name).to eq 'Pencil'
  end

  it '#description' do
    expect(@i.description).to eq 'YOU CAN USE IT TO WRITE THINGS'
  end

  it '#unit_price' do
    expect(@i.unit_price).to eq 0.1099e0
  end

  it '#created_at' do
    expect(@i.created_at).to be_a Time
  end

  it '#updated_at' do
    expect(@i.updated_at).to be_a Time
  end

  it '#merchant_id' do
    expect(@i.merchant_id).to eq 2
  end

  it '#unit_price_to_dollars' do
    expect(@i.unit_price_to_dollars).to eq 0.1099
  end
end
