require './test/spec_helper'

RSpec.describe SalesEngine do
  before :each do
    @sales_engine = SalesEngine.from_csv({
     :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
  end

  it 'exists' do
    expect(@sales_engine).to be_instance_of SalesEngine
  end

  it 'can return an array of all items' do
    expect(@sales_engine.item_repository).to be_instance_of ItemRepository
  end

  it 'can return an array of all merchants' do
    expect(@sales_engine.merchant_repository).to be_instance_of MerchantRepository
    expect(@sales_engine.merchant_repository.all).to be_a Array
    expect(@sales_engine.merchant_repository.all.length).to eq(475)
  end

  it "can return an array of all items" do
    expect(@sales_engine.item_repository.all.class).to equal(Array)
    expect(@sales_engine.item_repository.all[0].class).to equal(Item)
    expect(@sales_engine.item_repository.all[0].name).to eq("510+ RealPush Icon Set")
  end

  it "can find items by id" do
    expect(@sales_engine.item_repository.find_by_id(263395237).name).to eq("510+ RealPush Icon Set")
    expect(@sales_engine.item_repository.find_by_id(123456)).to equal(nil)
  end

  it "can find items by name" do
    expect(@sales_engine.item_repository.find_by_name("510+ RealPush Icon Set").id).to eq(263395237)
    expect(@sales_engine.item_repository.find_by_name("510+ REALPUSH Icon Set").id).to eq(263395237)
    expect(@sales_engine.item_repository.find_by_name("MINNIE MUG")).to eq(nil)
  end

  it "can find items by description" do
    expect(@sales_engine.item_repository.find_all_with_description("tkjlds;afdkla")).to eq([])
    expect(@sales_engine.item_repository.find_all_with_description("dress up your cupcakes").count).to eq(3)
  end

  it "can find items by price" do
    expect(@sales_engine.item_repository.find_all_by_price(BigDecimal(10)).count).to eq(63)
    expect(@sales_engine.item_repository.find_all_by_price(BigDecimal(1000000)).count).to eq(0)
    expect(@sales_engine.item_repository.find_all_by_price(BigDecimal(10))[0].class).to eq(Item)
    expect(@sales_engine.item_repository.find_all_by_price(BigDecimal(10))[0].id).to eq(263405861)
  end

  it "can find items in a range" do
    expect(@sales_engine.item_repository.find_all_by_price_in_range(1000.00..1500.00).count).to eq(19)
    expect(@sales_engine.item_repository.find_all_by_price_in_range(1000.00..1500.00)[0].id).to eq(263416567)
  end

  it "can find items by merchant id" do
    expect(@sales_engine.item_repository.find_all_by_merchant_id(12334145).count).to eq(7)
    expect(@sales_engine.item_repository.find_all_by_merchant_id(12336020).count).to eq(2)
    expect(@sales_engine.item_repository.find_all_by_merchant_id(12334145)[1].id).to eq(263401045)
    expect(@sales_engine.item_repository.find_all_by_merchant_id(9874098)).to eq([])
  end

  it "can create a new item" do
    new_item = @sales_engine.item_repository.create({name: "Batmobile", description: "Black and shiny", unit_price: BigDecimal(10000, 5), created_at: Time.now, updated_at: Time.now, merchant_id: 88877766})
    expect(new_item.id).to eq(263567475)
    expect(@sales_engine.item_repository.all.last.name).to eq("Batmobile")
  end

end
