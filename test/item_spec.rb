require_relative './spec_helper'
require "BigDecimal"

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

  it "is an instace of item" do
    expect(item).to be_instance_of Item
  end

  it "has an id" do
    expect(item.id).to eq(1)
  end

  it "has a name" do
    expect(item.name).to eq("Pencil")
  end

end
