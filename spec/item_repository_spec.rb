require_relative '../lib/item'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'

RSpec.describe ItemRepository do
  before :each do
    @item_repository =ItemRepository.new("./data/items.csv")
  end

  it "exists" do
    expect(@item_repository).to be_a ItemRepository
  end

  it "can return an array of all known items" do
    expect(@item_repository.all).to be_a Array
    expect(@item_repository.all.length).to eq(1367)
  end

  it "can find an item by id and return nil if not found" do
    expect(@item_repository.find_by_id(1)).to eq nil
    expect(@item_repository.find_by_id(263395237)).to be_a(Item)
    expect(@item_repository.find_by_id(263400793)).to be_a(Item)
  end

  it "can find an item by name and return nil if not found" do
    expect(@item_repository.find_by_name("Glitter scrabble frames")).to be_a(Item)
    expect(@item_repository.find_by_name("Cache cache à la plage")).to be_a(Item)
    expect(@item_repository.find_by_name("zero")).to eq nil
  end

  it "can find all by description and return an array or instances of item or nil" do
    expect(@item_repository.find_all_with_description("Acrylique")).to be_a(Array)
    expect(@item_repository.find_all_with_description("Acrylique").length).to eq(28)
    expect(@item_repository.find_all_with_description("Acrylique sur toile exécutée en 2009")[0]).to be_a(Item)
    expect(@item_repository.find_all_with_description("kung fu")).to eq([])
    expect(@item_repository.find_all_with_description("ideal for a romantic date")[0]).to be_a(Item)
  end

  it "can find an item that exactly matches by supplied price" do
    expect(@item_repository.find_all_by_price(12.00)).to be_a(Array)
    expect(@item_repository.find_all_by_price(12.00).first.unit_price).to eq(12.00)
    expect(@item_repository.find_all_by_price(4000)).to eq([])
  end

  it "can return an instance of an Item within a price range or [] " do
    price_in_range1 = @item_repository.find_all_by_price_in_range(1000.00..1500.00)
    expect(price_in_range1).to be_a(Array)
    expect(price_in_range1.length).to eq(19)
    expect(price_in_range1.first.id).to eq(263416567)
    price_in_range2 = @item_repository.find_all_by_price_in_range(10000..11000)
    expect(price_in_range2).to eq([])
  end

  it 'can find all items with same merchant id' do
    merchant_id = @item_repository.find_all_by_merchant_id(12334105)
    expect(merchant_id).to be_a(Array)
    expect(merchant_id.first).to be_a(Item)
    expect(merchant_id.first.id).to eq(263396209)
    expect(merchant_id.count).to eq(3)
    expect(@item_repository.find_all_by_merchant_id(1)).to eq([])
  end

  it "can create a new instance of item and add to repo" do
    attributes = {
        name: "Capita Defenders of Awesome 2018",
        description: "This board both rips and shreds",
        unit_price: BigDecimal(399.99, 5),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 25
      }
    @item_repository.create(attributes)
    expect(@item_repository.all.last).to be_a Item
    expect(@item_repository.all.last.name).to eq("Capita Defenders of Awesome 2018")
    expect(@item_repository.all.last.description).to eq("This board both rips and shreds")
    expect(@item_repository.all.last.unit_price).to be_a BigDecimal
    expect(@item_repository.all.last.created_at).to be_a Time
    expect(@item_repository.all.last.updated_at).to be_a Time
    expect(@item_repository.all.last.id).to eq(263567475)
  end

  it "can can update item instances " do
    attributes = {:name => "Book", :description => "Read this!", :unit_price => 1500}
    @item_repository.update(263395237, attributes)
    expect(@item_repository.find_by_id(263395237).name).to eq("Book")
    expect(@item_repository.find_by_id(263395237).description).to eq("Read this!")
    expect(@item_repository.find_by_id(263395237).unit_price).to be_a BigDecimal
    expect(@item_repository.find_by_id(263395237).updated_at).to be_a Time
  end

  it "can find an item by name and return nil if not found" do
    expect(@item_repository.find_by_name("Glitter scrabble frames")).to be_a(Item)
    expect(@item_repository.find_by_name("Cache cache à la plage")).to be_a(Item)
    expect(@item_repository.find_by_name("zero")).to eq nil
  end

  it "can find an item by description and return an array or instances of item" do
    expect(@item_repository.find_all_with_description("Acrylique")).to be_a(Array)
    expect(@item_repository.find_all_with_description("Acrylique sur toile exécutée en 2009")[0]).to be_a(Item)
    expect(@item_repository.find_all_with_description("Acrylique sur toile exécutée en 2012")[0]).to be_a(Item)
    expect(@item_repository.find_all_with_description("ideal for a romantic date")[0]).to be_a(Item)
  end

  it "can find an item that exactly matches by supplied price" do
    expect(@item_repository.find_all_by_price("1200")).to be_a(Array)
    expect(@item_repository.find_all_by_price(1200).first.unit_price).to eq(1200)
  end

  it "can delete the merchant instace" do
    deleted = @item_repository.delete(263395617)
    expect(deleted).to be_a Item
    expect(deleted.id).to eq(263395617)
    expect(@item_repository.all.first.id).to eq(263395237)
  end
end
