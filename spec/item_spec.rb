require './lib/item'

RSpec.describe Item do

  before :each do
    @item = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => 10.99,
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
})
  end

  it "exists" do
    expect(@item).to be_a(Item)
  end

  it "has an id" do
    expect(@item.id).to eq(1)
  end

  it "has a name" do
    expect(@item.name).to eq("Pencil")
  end

  it "has a description" do
    expect(@item.description).to eq("You can use it to write things")
  end

  it "has a unit_price" do
    expect(@item.unit_price).to eq(10.99)
  end

  it "has created_at" do
    expect(@item.created_at).to be_a(Time)
  end

  it "has updated_at" do
    expect(@item.updated_at).to be_a(Time)
  end

  it "has a merchant_id" do
    expect(@item.merchant_id).to eq(2)
  end
end
