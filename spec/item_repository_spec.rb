require './lib/item_repository'

RSpec.describe ItemRepository do
  before :each do
    @items = ItemRepository.new('./data/items.csv')
  end

  it "is an instance of ItemRepository" do
    expect(@items).to be_a(ItemRepository)
  end

  it "can find items by their id" do
    expect(@items.find_by_id(263395237).name).to eq("510+ RealPush Icon Set")
    expect(@items.find_by_id(0)).to eq(nil)
  end

  it "can find items by their name" do
    expect(@items.find_by_name("510+ RealPush Icon Set").name).to eq("510+ RealPush Icon Set")
    expect(@items.find_by_name("I made this up")).to eq(nil)
  end

  it "can list items by their description" do
    expect(@items.find_all_with_description("Pleasant to touch...").length).to eq(2)
    expect(@items.find_all_with_description("This doesn't exist!")).to eq([])
  end

  it 'can find all items with a certain price' do
    expect(@items.find_all_by_price(2131232132)).to eq []
    price = BigDecimal(25)
    expect(@items.find_all_by_price(price).count).to eq 79
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
    expect(@items.find_all_by_merchant_id(12334871).length).to eq(4)
  end

  it "can make a new item" do
    attributes = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(1099, 5),
      :created_at  => Time.parse('1994-05-07 23:38:43 UTC'),
      :updated_at  => Time.parse('2016-01-11 11:30:35 UTC'),
      :merchant_id => 2
    }
    @items.create(attributes)
    expect(@items.find_by_name("Pencil")).to be_a(Item)
  end

  it "has the largest id number" do
    attributes = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(1099, 5),
      :created_at  => Time.parse('1994-05-07 23:38:43 UTC'),
      :updated_at  => Time.parse('2016-01-11 11:30:35 UTC'),
      :merchant_id => 2
    }
    @items.create(attributes)
    expect(@items.find_by_id(263567475).name).to eq("Pencil")
  end

  it "has a price" do
    attributes = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(1099, 5),
      :created_at  => Time.parse('1994-05-07 23:38:43 UTC'),
      :updated_at  => Time.parse('2016-01-11 11:30:35 UTC'),
      :merchant_id => 2
    }
    @items.create(attributes)
    expect(@items.find_by_id(263567475).unit_price).to eq(10.99)
  end

  it 'has a helper method to help assign attributes' do
    attributes = {
      unit_price: BigDecimal(379.99, 5)
    }
    item = @items.find_by_id(263395237)
    @items.assign_attributes(item, attributes)
    expect(item.unit_price).to eq 379.99
  end

  it "can update the item's attributes" do
    attributes = {
      unit_price: BigDecimal(379.99, 5)
    }
    @items.update(263395237, attributes)
    expect(@items.find_by_id(263395237).unit_price).to eq(379.99)
  end

  it 'can delete items' do
    expect(@items.find_by_id(263395237)).to be_a Item
    @items.delete(263395237)
    expect(@items.find_by_id(263395237)).to be nil
  end
end
