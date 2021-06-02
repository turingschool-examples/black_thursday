require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe Item do

  it "exists" do

    i = Item.new({
    :id          => 1,
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 2
    })

    expect(i).to be_a(Item)
  end

  it "has attributes" do

    i = Item.new({
    :id          => 1,
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal(10.99, 4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 2
    })

    expect(i.id).to eq(1)
    expect(i.name).to eq("Pencil")
    expect(i.description).to eq("You can use it to write things")
    expect(i.unit_price).to eq(BigDecimal(10.99, 4))
    expect(i.merchant_id).to eq(2)

    time_now = '2021-05-30 11:30:51.343158 -050'
    allow(i).to receive(:created_at).and_return(time_now)
    allow(i).to receive(:updated_at).and_return(time_now)
    #stub works when i.created_at is called but when i is initialized, the stubbed variable is not passed into i.created_at

    expect(i.created_at).to eq(time_now)
    expect(i.updated_at).to eq(time_now)

  end

  it "stores its states in a hash" do

    time_now = '2021-05-30 11:30:51.343158 -050'
    i = Item.new({
    :id          => 1,
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal(10.99, 4),
    :created_at  => time_now, #Time.now,
    :updated_at  => time_now, #Time.now,
    :merchant_id => 2
    })

    # allow(i).to receive(:created_at).and_return(time_now)
    # allow(i).to receive(:updated_at).and_return(time_now)

    i_hash = i.to_hash

    expect(i_hash).to be_a(Hash)
    expect(i_hash.keys.length).to eq(7)
    expect(i_hash.values.length).to eq(7)
    expect(i_hash[:id]).to eq(i.id)
    expect(i_hash[:name]).to eq(i.name)
    expect(i_hash[:description]).to eq(i.description)
    expect(i_hash[:unit_price]).to eq(i.unit_price)
    expect(i_hash[:created_at]).to eq(i.created_at)
    expect(i_hash[:updated_at]).to eq(i.updated_at)
  end

  it "can convert unit price into dollars" do

    i = Item.new({
    :id          => 1,
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal(10.99, 4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 2
    })

    expect(i.unit_price_to_dollars).to eq(10.99)
  end


end
