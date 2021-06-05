require_relative 'spec_helper'
require_relative '../lib/item'
require 'csv'
require 'bigdecimal'

RSpec.describe Item do
  it 'exists' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => "2021-06-01 18:37:52.006093 -0400",
      :updated_at  => Time.now,
      :merchant_id => 2
      }, nil)
    expect(i).to be_a(Item)
  end

  it 'has attributes' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => "2021-06-01 18:37:52.006093 -0400",
      :updated_at  => Time.now,
      :merchant_id => 2
      }, nil)


    expect(i.id).to eq(1)
    expect(i.name).to eq("Pencil")
    expect(i.description).to eq("You can use it to write things")
    expect(i.unit_price).to eq(BigDecimal(10.99,4))
    expect(i.created_at).to eq("2021-06-01 18:37:52.006093 -0400")
    # require"pry";binding.pry
    result = i.updated_at.to_s[0..3]
    expect(result).to eq("2021")
    expect(i.merchant_id).to eq(2)
  end

  it 'returns unit_price as a float' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => "2021-06-01 18:37:52.006093 -0400",
      :updated_at  => Time.now,
      :merchant_id => 2
      }, nil)

    expect(i.unit_price_to_dollars).to eq(10.99)
  end

  it 'can create an item' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => "2021-06-01 18:37:52.006093 -0400",
      :updated_at  => Time.now,
      :merchant_id => 2
      }, nil)

      expect(i.id).to eq(1)
      expect(i.name).to eq("Pencil")
      expect(i.description).to eq("You can use it to write things")
      expect(i.unit_price).to eq(0.1099e2)
      expect(i.merchant_id).to eq(2)
  end

  it 'can updaet an item' do
    i = Item.new({
      :id          => 2,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => "2021-06-01 18:37:52.006093 -0400",
      :updated_at  => Time.now,
      :merchant_id => 3
      }, nil)

      new_time = Time.now

      i.update({
        :id          => 2,
        :name        => "Pen",
        :description => "You can write things",
        :unit_price  => BigDecimal(11.99,4),
        :created_at  => "2021-07-01 18:37:52.006093 -0400",
        :updated_at  => new_time,
        :merchant_id => 3
        })


      expect(i.id).to eq(2)
      expect(i.name).to eq("Pen")
      expect(i.description).to eq("You can write things")
      expect(i.unit_price).to eq(0.1199e2)
  end
end


# allow_any_instance_of(Time).to receive(:now).and_return(2021)
