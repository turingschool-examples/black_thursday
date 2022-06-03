require 'simplecov'
SimpleCov.start
require 'helper'

RSpec.describe ItemRepository do

  before :each do
    @item_repository = ItemRepository.new("./data/items.csv")
  end

  it 'exists' do
    expect(@item_repository).to be_instance_of(ItemRepository)
  end

  it 'returns array of all item instances' do
    expect(@item_repository.all).to be_instance_of(Array)
  end

  it 'returns array of all item instances' do
    expect(@item_repository.all.count).to be > 20
  end

  it 'returns item instance by ID' do
    expect(@item_repository.find_by_id(263438579).name).to eq("Air Jordan Coloring Book")
  end

  it 'returns item instance by name' do
    expect(@item_repository.find_by_name("Air Jordan Coloring Book").id).to eq(263438579)
  end

  it 'returns item instance by name, case insensitive' do
    expect(@item_repository.find_by_name("Air JORDAN Coloring BoOK").id).to eq(263438579)
  end

  it 'returns item instance by name, ignoring leading/trailing spaces' do
    expect(@item_repository.find_by_name("   Air JORDAN Coloring BoOK   ").id).to eq(263438579)
  end

  it 'returns all items with a specified description' do
    expect(@item_repository.find_all_with_description("coffee")).to be_instance_of(Array)
    expect(@item_repository.find_all_with_description("coffee").count).to eq(8)
  end

  it 'returns all items with a specified price' do
    expect(@item_repository.find_all_by_price(150.00)).to be_instance_of(Array)
    expect(@item_repository.find_all_by_price(150.00).count).to eq(1)
  end

  it 'returns all items in specified price range' do
    expect(@item_repository.find_all_by_price_in_range(5,40)).to be_instance_of(Array)
    expect(@item_repository.find_all_by_price_in_range(5,40).count).to eq(1)
  end

  it 'returns all items with specified merchant ID' do
    expect(@item_repository.find_all_by_merchant_id(12334185)).to be_instance_of(Array)
    expect(@item_repository.find_all_by_merchant_id(12334185).count).to eq(6)
  end

  it 'returns max item id' do
    expect(@item_repository.max_item_id).to eq(263567474)
  end

  it 'can create new item instances' do
    expect(@item_repository.max_item_id).to eq(263567474)

    @item_repository.create("SNACK CHEST","A big treasure chest filled with snacks",30,9999)

    expect(@item_repository.max_item_id).to eq(263567475)

    expect(@item_repository.find_by_name("SNACK CHEST").id).to eq(263567475)
  end

  it 'can update item instances' do
    expect(@item_repository.find_by_id(263438579).name).to eq("Air Jordan Coloring Book")

    @item_repository.update(263438579,"Scare Jordan Haunted Halloween Book","A very spooky basketball novelization",600)

    expect(@item_repository.find_by_id(263438579).name).to eq("Scare Jordan Haunted Halloween Book")
  end

  it 'can delete item instances' do
    expect(@item_repository.all.count).to eq(1367)

    @item_repository.delete(263438579)

    expect(@item_repository.all.count).to eq(1366)
  end

end
