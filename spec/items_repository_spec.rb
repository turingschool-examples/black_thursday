require 'rspec'
require 'bigdecimal'
require './lib/items_repository'

describe ItemsRepository do
  before(:each) do
    @ir = ItemsRepository.new("./data/items.csv")
  end

  it "exists" do
    expect(@ir).to be_an_instance_of(ItemsRepository)
  end

  it 'lists all items' do
    expect(@ir.all).to eq(@ir.repository)
  end

  it 'can find an item by the id' do
    item = @ir.find_by_id("263395237")
    expect(item.name).to eq("510+ RealPush Icon Set")
    expect(item.unit_price).to eq("1200")
  end

  it 'can find an item by the name' do
    item = @ir.find_by_name("510+ RealPush Icon Set")
    expect(item.id).to eq("263395237")
    expect(item.unit_price).to eq("1200")
  end

  it 'can find all items with specific description' do
    item = @ir.find_all_with_description("Acrylique sur toile exécutée en 2011")

    expect(item.count).to eq(3)
  end

  it 'can find all items with specific price' do
    item = @ir.find_all_by_price("50000")

    expect(item.count).to eq(11)
  end

  it 'can find all items within price range' do
    item = @ir.find_all_by_price_in_range("40000", "50000")

    expect(item.count).to eq(26)
    expect(item[0].id).to eq('263396517')
  end

  it 'can find all items with specific merchant_id' do
    item = @ir.find_all_by_merchant_id("12334195")
    expect(item.count).to eq(20)
    expect(item[0].unit_price).to eq('14900')
  end

  it 'creates new items with highest id' do
    item = @ir.create({
      :id          => nil,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(11.55,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    expect(item.id).to eq("263567475")
    expect(@ir.find_all_by_price(BigDecimal(11.55,4))).to eq([item])
  end

  it 'can update item names, descriptions, and unit_price' do
    item = @ir.find_by_id("263567474")
    first_update = item.updated_at

    expect(item.name).to eq("Minty Green Knit Crochet Infinity Scarf")
    expect(item.description).to eq("- Super Chunky knit infinity scarf
- Soft mixture of 97% Acrylic and 3% Viscose
- Beautiful, Warm, and Stylish
- Very easy to care for

Hand wash with cold water and lay flat to dry")

    @ir.update("263567474", {name: "Johnny's Wizarding Whimsicals", description: "new description", unit_price: 6})

    expect(@ir.find_by_id('263567474').name).to eq("Johnny's Wizarding Whimsicals")
    expect(item.description).to eq("new description")
    expect(item.unit_price).to eq(6)
    expect(item.updated_at).not_to eq(first_update)
  end

end
