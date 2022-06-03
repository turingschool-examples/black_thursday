require './lib/item.rb'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/merchant'

RSpec.describe ItemRepository do
  it "exists" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo).to be_a(ItemRepository)
  end

  it "can return an array of all known item instances" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.all.count).to eq(1367)
  end

  it "can find item by ID" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.find_by_id(263400305)).to be_a(Item)
    expect(item_repo.find_by_id(12345678910)).to eq(nil)
  end

  it "can find an item by name" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.find_by_name("Free standing Woden letters")).to be_instance_of(Item)
    expect(item_repo.find_by_name("FREE stANDing wOdeN lEttErs")).to be_instance_of(Item)
    expect(item_repo.find_by_name("InvalidName")).to eq(nil)
  end

  it "can return an item by parts of a description" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.find_all_with_description("Disney")).to be_instance_of(Array)
    expect(item_repo.find_all_with_description("dISneY")).to be_instance_of(Array)
    #This next one was tricky, I had to look through the items.csv, and filter
    #out anything that wasn't a specific item (lots of pitches, dialogues)
    expect(item_repo.find_all_with_description("Disney").length).to eq (5)
    expect(item_repo.find_all_with_description("Thiago")).to eq([])
  end

  it "can find all items by price" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.find_all_by_price("1300")).to be_instance_of(Array)
    expect(item_repo.find_all_by_price("1,000,000")).to eq([])
  end

  it "can find all items by price in a range" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.find_all_by_price_in_range(1..1400)).to be_instance_of(Array)
    expect(item_repo.find_all_by_price_in_range(0..0)).to eq([])
  end

  it "can find all by merchant id" do
    item_repo = ItemRepository.new('./data/items.csv')
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(item_repo.find_all_by_merchant_id(12334105)).to be_instance_of(Array)
    expect(item_repo.find_all_by_merchant_id(12345678910112)).to eq([])
  end

  #Ask instructor if only adding a name for a new item is okay...Ran out of time lol.
  it "can create a new item with provided attributes" do
    item_repo = ItemRepository.new('./data/items.csv')
    new_item_attributes = {:name => "Oreos", :description => "a sandwich cookie",
    :unit_price => "50", }
    new_item = (item_repo.create(new_item_attributes))
    expect(new_item.name).to eq("Oreos")
    expect(new_item.unit_price).to eq("50")
    expect(new_item.description).to eq("a sandwich cookie")
    expect(new_item.created_at).to be_instance_of(Time)
    expect(item_repo.find_by_id(263567475)).to be_a(Item)
  end

  it "can update an item's attributes" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.find_by_id(263567474).name).to eq("Minty Green Knit Crochet Infinity Scarf")
    expect(item_repo.find_by_id(263567474).description).to eq("- Super Chunky knit infinity scarf\n- Soft mixture of 97% Acrylic and 3% Viscose\n- Beautiful, Warm, and Stylish\n- Very easy to care for\n\nHand wash with cold water and lay flat to dry")
    expect(item_repo.find_by_id(263567474).unit_price).to eq("3800")
    new_test_attributes = {:name => "New Test Scarf", :description => "A beautiful testing scarf", :unit_price => "1"}
    item_repo.update(263567474, new_test_attributes)
    expect(item_repo.find_by_id(263567474).name).to eq("New Test Scarf")
    expect(item_repo.find_by_id(263567474).description).to eq("A beautiful testing scarf")
    expect(item_repo.find_by_id(263567474).unit_price).to eq("1")
    expect(item_repo.find_by_id(263567474).updated_at).to be_instance_of(Time)
  end

  it "can delete an item" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.find_by_id(263567474)).to be_a(Item)
    item_repo.delete(263567474)
    expect(item_repo.find_by_id(263567474)).to eq(nil)
  end
end
