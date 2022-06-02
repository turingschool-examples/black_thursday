require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/item"
require "./lib/merchant_repository"
require "./lib/merchant"

#You may need to add more `expect` lines to each test to make it more robust...!
RSpec.describe ItemRepository do
  before(:each) do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
      @item_repo = se.items
  end

  it 'exists' do
    expect(@item_repo).to be_a(ItemRepository)
  end

  it 'has an array of items' do
    expect(@item_repo.all).to be_a(Array)
    expect(@item_repo.all.length).to eq(1367)
    expect(@item_repo.all.first).to be_a(Item)
    expect(@item_repo.all.first.id).to eq(263395237)
  end

  it 'Can find by id' do
    expect(@item_repo.find_by_id(263395237)).to be_a(Item)
    expect(@item_repo.find_by_id(263395237).name).to eq("510+ RealPush Icon Set")

  end


  it 'Can find by name' do
    expect(@item_repo.find_by_name("510+ RealPush Icon Set")).to be_a(Item)
    expect(@item_repo.find_by_name("510+ RealPush Icon Set").id).to eq(263395237)

  end

  it 'Can find by description' do
    expect(@item_repo.find_by_description("510+ icons")).to eq([@item_repo.all.first])
    expect(@item_repo.find_by_description("adsflkjhweoth")).to eq([])
  end

  it 'can find by price' do
    expect(@item_repo.find_all_by_price(3700)).to eq([@item_repo.find_by_id(263400233)])
    expect(@item_repo.find_all_by_price(2349873495732)).to eq([])
  end

  it 'can find by price in range' do
    expect(@item_repo.find_all_by_price_in_range(3699.. 3701)).to be_a(Array)
    expect(@item_repo.find_all_by_price_in_range(3699 .. 3701).length).to eq(1)
    expect(@item_repo.find_all_by_price_in_range(2349873495732 .. 324987345902739)).to eq([])
  end

  it 'Can find all by merchant id' do
    expect(@item_repo.find_all_by_merchant_id(12334141)).to be_a(Array)
    expect(@item_repo.find_all_by_merchant_id(12334141).length).to eq(1)
    expect(@item_repo.find_all_by_merchant_id(12334141345436)).to eq([])
  end

  it 'Can create an item' do
    @item_repo.create({
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now.round,
        :updated_at  => Time.now.round,
        :merchant_id => 2
        })

      expect(@item_repo.all.length).to eq(1368)
  end

  it 'find the largest id #' do
    expect(@item_repo.find_max_id).to eq(263567474)
  end

  it 'can update attributes' do
    attributes = {name: "+511 fakepush icons", description: "Icon pack or something", unit_price: 1000.0}
    @item_repo.update(263395237, attributes)
    expect(@item_repo.find_by_id(263395237).name).to eq("+511 fakepush icons")

  end

  it 'can delete by id' do
    @item_repo.delete(263395237)
    expect(@item_repo.all.length).to eq(1366)
    expect(@item_repo.find_by_id(263395237)).to eq(nil)
  end
end
