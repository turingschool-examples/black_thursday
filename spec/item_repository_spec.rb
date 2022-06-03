require './lib/item_repository'

RSpec.describe ItemRepository do
  before :each do
    @items = ItemRepository.new('./data/items.csv')
  end

  it "is an instance of ItemRepository" do
    expect(@items).to be_a(ItemRepository)
  end

  it "can find items by their id" do
    expect(@items.find_by_id("263395237").name).to eq("510+ RealPush Icon Set")
    expect(@items.find_by_id("0")).to eq(nil)
  end

  it "can find items by their name" do
    expect(@items.find_by_name("510+ RealPush Icon Set").name).to eq("510+ RealPush Icon Set")
    expect(@items.find_by_name("I made this up")).to eq(nil)
  end

  it "can list items by their description" do
    expect(@items.find_all_with_description("Pleasant to touch...").length).to eq(1)
    expect(@items.find_all_with_description("This doesn't exist!")).to eq([])
  end

  it "list items by their price" do
    expect(@items.find_all_with_price(0)).to eq([])
    expect(@items.find_all_with_price(1300).length).to eq(8)
  end

  it "can list items within a certain price range" do
    expect(@items.find_all_by_price_in_range(13.0..14.0).length).to eq(22)
    expect(@items.find_all_by_price_in_range(0..0)).to eq([])
  end

  it "can list items by merchant id" do
    expect(@items.find_all_by_merchant_id(0)).to eq([])
    expect(@items.find_all_by_merchant_id("12334871").length).to eq(4)
  end

  it "can make a new item" do
    @items.create({
      :id          => 0,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :created_at  => '1994-05-07 23:38:43 UTC',
      :updated_at  => '2016-01-11 11:30:35 UTC',
      :merchant_id => 2
    })
    expect(@items.find_by_name("Pencil")).to be_a(Item)
  end

  it "has the largest id number" do
    @items.create({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :created_at  => '1994-05-07 23:38:43 UTC',
      :updated_at  => '2016-01-11 11:30:35 UTC',
      :merchant_id => 2
    })
    expect(@items.find_by_id("263567475").name).to eq("Pencil")
  end

  it "has a price" do
    @items.create({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :created_at  => '1994-05-07 23:38:43 UTC',
      :updated_at  => '2016-01-11 11:30:35 UTC',
      :merchant_id => 2
    })
    expect(@items.find_by_id("263567475").unit_price).to eq(10.99)
  end

  it "can update the item's attributes" do
    @items.create({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :created_at  => '1994-05-07 23:38:43 UTC',
      :updated_at  => '2016-01-11 11:30:35 UTC',
      :merchant_id => 2
    })
    @items.update("263567475", {:name => "Pen", :description => "You can write things sitll",
      :unit_price => 1299, :updated_at => '2022-01-11 11:30:35 UTC'})
    expect(@items.find_by_id("263567475").name).to eq("Pen")
  end



end
