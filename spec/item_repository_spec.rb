require'./lib/item'
require'./item_repository'
require'BigDecimal'
# require_relative 'merchant'
# require_relative 'merchant_repository'
require 'pry'

RSpec.describe ItemRepository do
  before :each do
    @item_repository = ItemRepository.new("./data/items.csv")
  end

  it 'exists' do
    expect(@item_repository).to be_a ItemRepository
  end

  it 'returns an array of all item instances' do
    expect(@item_repository.all).to be_a Array
    expect(@item_repository.all.count).to eq(1367)
  end

  it 'can find by id' do
    expect(@item_repository.find_by_id(263395237)).to eq(@item_repository.all.first)
    expect(@item_repository.find_by_id(1233)).to eq(nil)
    expect(@item_repository.find_by_id(263395237)).to be_a(Item)
  end

  it "can find_by_name" do

    expect(@item_repository.find_by_name("510+ RealPush Icon Set")).to eq(@item_repository.all.first)
    expect(@item_repository.find_by_name("XYZ")).to eq(nil)
    expect(@item_repository.find_by_name("510+ RealPush Icon Set")).to be_a(Item)
  end

  it 'can find_all_with_descriprion(description)' do
    test = @item_repository.find_all_with_description("Any colour glitter")

    expect(@item_repository.find_all_with_description("Any colour glitter").count).to eq(4)
    expect(@item_repository.find_all_with_description("Any colour glitter")).to be_a(Array)
    expect(@item_repository.find_all_with_description("aNy CoLoUr GlItTeR").first.id).to eq 263395617

    expect(test.map(&:id).include?(263395721)).to eq true
  end

  it 'finds item by price' do
    test = @item_repository.find_all_by_price(1200.00)
#binding.pry
    expect(test.first).to eq(test.first)
    expect(test).to be_a(Array)
    expect(test.count).to eq 41
  end

  it 'finds price by range' do
    test = @item_repository.find_all_by_price_in_range(0.00..1200.00)

    expect(test.first).to eq(test.first)
    expect(test).to be_a(Array)
    expect(test.count).to eq 350
  end

  it 'find all by merchant id' do
    test = @item_repository.find_all_by_merchant_id(12334185)

    expect(test).to be_a(Array)
    expect(test.count).to eq 6
    expect(test.first.id).to eq 263395617

  end

  it "creates attributes" do
    attributes = {
      name: "BryceGems",
      description: "Any colour gems",
      unit_price: BigDecimal(420.00, 5),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 25
    }



    expect(@item_repository.create(attributes).last.id).to eq(263567475)
    expect(@item_repository.all.last).to be_a(Item)
    expect(@item_repository.all.count).to eq 1368
  end

  it "can update(id, attributes)" do
    x = Time.now
    attributes = {
      name: "BryceGems",
      description: "Any colour gems",
      unit_price: BigDecimal(420.00, 5),
      created_at: x,
      updated_at: x,
      merchant_id: 25
    }

    @item_repository.update(263567474, attributes)

    expect(@item_repository.find_by_id(263567474).name).to eq("BryceGems")
    expect(@item_repository.find_by_name("Minty Green Knit Crochet Infinity Scarf")).to eq(nil)
    expect(@item_repository.find_by_id(263567474).updated_at).to be > x
  end


end
