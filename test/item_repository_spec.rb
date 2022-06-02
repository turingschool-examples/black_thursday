require_relative './spec_helper'

RSpec.describe ItemRepository do
  before :each do
    @item_repo = ItemRepository.new("./data/items.csv")
  end

  it 'will be an instance of ItemRepository' do
    expect(@item_repo).to be_instance_of ItemRepository
  end

  it 'has an all function' do
    expect(@item_repo.all.class).to equal(Array)
    expect(@item_repo.all[0].class).to equal(Item)
    expect(@item_repo.all[0].name).to eq("510+ RealPush Icon Set")
  end

  it 'has a find by id function' do
    expect(@item_repo.find_by_id(263395237).name).to eq("510+ RealPush Icon Set")
    expect(@item_repo.find_by_id(123456)).to equal(nil)
  end

  it 'has a find by name function' do
    expect(@item_repo.find_by_name("510+ RealPush Icon Set").id).to eq(263395237)
    expect(@item_repo.find_by_name("510+ REALPUSH Icon Set").id).to eq(263395237)
    expect(@item_repo.find_by_name("MINNIE MUG")).to eq(nil)
  end

  it 'can find items by description' do
    expect(@item_repo.find_all_with_description("tkjlds;afdkla")).to eq([])
    expect(@item_repo.find_all_with_description("dress up your cupcakes").count).to eq(3)
  end

  it 'can find items by price' do
    expect(@item_repo.find_all_by_price(BigDecimal(10)).count).to eq(63)
    expect(@item_repo.find_all_by_price(BigDecimal(1000000)).count).to eq(0)
    expect(@item_repo.find_all_by_price(BigDecimal(10))[0].class).to eq(Item)
    expect(@item_repo.find_all_by_price(BigDecimal(10))[0].id).to eq(263405861)
  end

  it "can find all items in a range" do
    expect(@item_repo.find_all_by_price_in_range(1000.00..1500.00).count).to eq(19)
    expect(@item_repo.find_all_by_price_in_range(1000.00..1500.00)[0].id).to eq(263416567)
  end

  it "can find items by merchant id" do
    expect(@item_repo.find_all_by_merchant_id(12334145).count).to eq(7)
    expect(@item_repo.find_all_by_merchant_id(12336020).count).to eq(2)
    expect(@item_repo.find_all_by_merchant_id(12334145)[1].id).to eq(263401045)
    expect(@item_repo.find_all_by_merchant_id(9874098)).to eq([])
  end

  it "can create a new item" do
    new_item = @item_repo.create({name: "Batmobile", description: "Black and shiny", unit_price: BigDecimal(10000, 5), created_at: Time.now, updated_at: Time.now, merchant_id: 88877766})
    expect(new_item.id).to eq(263567475)
    expect(@item_repo.all.last.name).to eq("Batmobile")
  end

  it "can update the item and items attributes" do
    new_item = @item_repo.create({name: "Batmobile", description: "Black and shiny", unit_price: BigDecimal(10000, 5), created_at: Time.now, updated_at: Time.now, merchant_id: 88877766})
    original_time = @item_repo.find_by_id(263567475).updated_at
    attributes = {unit_price: BigDecimal(379.99, 5)}
    @item_repo.update(263567475, attributes)
    expect(@item_repo.find_by_id(263567475).unit_price).to eq(BigDecimal(379.99, 5))
    expect(@item_repo.find_by_id(263567475).updated_at).to be > original_time
    attributes_2 = {name: "Batmobile Extreme"}
    @item_repo.update(263567475, attributes_2)
    expect(@item_repo.find_by_id(263567475).name).to eq("Batmobile Extreme")
    attributes_3 = {description: "Big and very loud"}
    @item_repo.update(263567475, attributes_3)
    expect(@item_repo.find_by_id(263567475).description).to eq("Big and very loud")
  end

  it "can delete things" do
    new_item = @item_repo.create({name: "Batmobile", description: "Black and shiny", unit_price: BigDecimal(10000, 5), created_at: Time.now, updated_at: Time.now, merchant_id: 88877766})
    @item_repo.delete(263567475)
    expect(@item_repo.find_by_id(263567475)).to eq(nil)
  end

end
