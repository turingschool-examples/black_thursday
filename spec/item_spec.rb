require_relative 'spec_helper'
require_relative '../lib/item'
require 'csv'
require 'bigdecimal'

RSpec.describe Item do
  before :each do
    @time = Time.now.utc.strftime("%m-%d-%Y %H:%M:%S %Z")
    @repo = double('repo')
    @i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :created_at  => @time,
      :updated_at  => @time,
      :merchant_id => 2
      }, @repo)
  end


  it 'exists' do

    expect(@i).to be_a(Item)
  end

  it 'has attributes' do

    expect(@i.id).to eq(1)
    expect(@i.name).to eq("Pencil")
    expect(@i.description).to eq("You can use it to write things")
    expect(@i.unit_price).to eq(0.1099e2)
    expect(@i.created_at).to eq(Time.parse(@time))
    expect(@i.updated_at).to eq(Time.parse(@time))
    expect(@i.merchant_id).to eq(2)
  end

  it 'returns unit_price in dollars' do

    expect(@i.unit_price_to_dollars).to eq(10.99)
  end

  it 'can create an item' do
    attributes = {
      :name => "Marker",
      :description => "You can write colorfully",
      :unit_price => BigDecimal(12.00,4),
    }

    allow(@repo).to receive(:new_item_id_number).and_return(5)
    expect(Item.create_item(attributes, @repo)).to be_a(Item)
  end

  it 'can update an item' do

      new_attributes = {
        :name        => "Pen",
        :description => "You can write important things",
        :unit_price  => BigDecimal(11.99,4)
        }

      @i.update_item(new_attributes)

      expect(@i.name).to eq("Pen")
      expect(@i.description).to eq("You can write important things")
      expect(@i.unit_price).to eq(0.1199e2)
  end
end


# allow_any_instance_of(Time).to receive(:now).and_return(2021)
