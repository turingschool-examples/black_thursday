require_relative 'item'
require 'bigdecimal'

RSpec.describe Item do
  it "has attributes" do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    expect(i.id).to eq(1)
    expect(i.name).to eq("Pencil")
    expect(i.description).to eq("You can use it to write things")
    expect(i.unit_price).to eq(BigDecimal(10.99,4))
    expect(i.created_at).to be_an_instance_of(Time)
    expect(i.updated_at).to be_an_instance_of(Time)
    expect(i.merchant_id).to eq(2)
  end

  it "can convert unit price to dollars" do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
      })

    expect(i.unit_price_to_dollars).to eq(10.99)
  end
end
