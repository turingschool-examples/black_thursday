require 'CSV'
require 'pry'
require_relative '../lib/item_repository.rb'
require_relative '../lib/item.rb'
require 'simplecov'
SimpleCov.start

RSpec.describe ItemRepository do
  it "initializes" do
    repo = ItemRepository.new [Item.new({ id: 1, name: "test", description: "test_description", unit_price: 1,
                                          created_at: "8:07pm UTC", updated_at: "2:34pm UTC", merchant_id: 001 })]
    expect(repo).to be_an_instance_of(ItemRepository)
    expect(repo.all[0]).to be_an_instance_of(Item)
  end


  it 'finds by id' do
    item1 = Item.new({ id: 1, name: "test", description: "test_description", unit_price: 1, created_at: "8:07pm UTC",
                       updated_at: "2:34pm UTC", merchant_id: 001 })
    item2 = Item.new({ id: 2, name: "test-test", description: "another test description", unit_price: 3,
                       created_at: "12:00am utc", udpated_at: "12:00pm UTC", merchant_id: 001 })
    repo = ItemRepository.new([item1, item2])
    expect(repo.find_by_id(1)).to be(item1)
  end

  it 'finds by name' do
    item1 = Item.new({ id: 1, name: "test", description: "test_description", unit_price: 1, created_at: "8:07pm UTC",
                       updated_at: "2:34pm UTC", merchant_id: 001 })
    item2 = Item.new({ id: 2, name: "test-test", description: "another test description", unit_price: 3,
                       created_at: "12:00am utc", udpated_at: "12:00pm UTC", merchant_id: 001 })
    repo = ItemRepository.new([item1, item2])
    expect(repo.find_by_name("TeSt")).to be(item1)
  end

  it "finds by description" do
    item1 = Item.new({ id: 1, name: "test", description: "test_description", unit_price: 1, created_at: "8:07pm UTC",
                       updated_at: "2:34pm UTC", merchant_id: 001 })
    item2 = Item.new({ id: 2, name: "test-test", description: "another test description", unit_price: 3,
                       created_at: "12:00am utc", udpated_at: "12:00pm UTC", merchant_id: 001 })
    repo = ItemRepository.new([item1, item2])

    expect(repo.find_all_with_description("TE")).to eq([item1, item2])
  end

  it "finds all items by price" do
    item1 = Item.new({ id: 1, name: "test", description: "test_description", unit_price: 1, created_at: "8:07pm UTC",
                       updated_at: "2:34pm UTC", merchant_id: 001 })
    item2 = Item.new({ id: 2, name: "test-test", description: "another test description", unit_price: 3,
                       created_at: "12:00am utc", udpated_at: "12:00pm UTC", merchant_id: 001 })
    repo = ItemRepository.new([item1, item2])

    expect(repo.find_all_by_price(1)).to eq([item1])
    expect(repo.find_all_by_price(2)).to eq([])
    expect(repo.find_all_by_price(3)).to eq([item2])

    item2 = Item.new({ id: 2, name: "test-test", description: "another test description", unit_price: 1,
                       created_at: "12:00am utc", udpated_at: "12:00pm UTC", merchant_id: 001 })
    repo = ItemRepository.new([item1, item2])
    expect(repo.find_all_by_price(1)).to eq([item1, item2])
  end

  it "finds all items within a price range" do
    item1 = Item.new({ id: 1, name: "test", description: "test_description", unit_price: 1, created_at: "8:07pm UTC",
                       updated_at: "2:34pm UTC", merchant_id: 001 })
    item2 = Item.new({ id: 2, name: "test-test", description: "another test description", unit_price: 3,
                       created_at: "12:00am utc", udpated_at: "12:00pm UTC", merchant_id: 001 })
    repo = ItemRepository.new([item1, item2])

    expect(repo.find_all_by_price_in_range(0..2)).to eq([item1])
    expect(repo.find_all_by_price_in_range(5..7)).to eq([])
    expect(repo.find_all_by_price_in_range(1..3)).to eq([item1, item2])
  end

  it "finds all items by a given merchant number" do
    item1 = Item.new({ id: 1, name: "test", description: "test_description", unit_price: 1, created_at: "8:07pm UTC",
                       updated_at: "2:34pm UTC", merchant_id: 001 })
    item2 = Item.new({ id: 2, name: "test-test", description: "another test description", unit_price: 3,
                       created_at: "12:00am utc", udpated_at: "12:00pm UTC", merchant_id: 001 })
    repo = ItemRepository.new([item1, item2])

    expect(repo.find_all_by_merchant_id(001)).to eq([item1, item2])

    item2 = Item.new({ id: 2, name: "test-test", description: "another test description", unit_price: 3,
                       created_at: "12:00am utc", udpated_at: "12:00pm UTC", merchant_id: 002 })
    repo = ItemRepository.new([item1, item2])

    expect(repo.find_all_by_merchant_id(001)).to eq([item1])
  end

  it "creates a new item in the @all library with given attributes and the next sequential ID number" do
    item1 = Item.new({ id: 1, name: "test", description: "test_description", unit_price: 1, created_at: "8:07pm UTC",
                       updated_at: "2:34pm UTC", merchant_id: 001 })
    item2 = Item.new({ id: 2, name: "test-test", description: "another test description", unit_price: 3,
                       created_at: "12:00am utc", udpated_at: "12:00pm UTC", merchant_id: 001 })
    repo = ItemRepository.new([item1, item2])

    item3 = repo.create({ id: 1, name: "Test Item 3", description: "test_description", unit_price: 5, created_at: "9:07pm UTC",
                  updated_at: "7:26am UTC", merchant_id: 002 })
    expect(repo.all.length).to eq(3)
    expect(repo.all[2].class).to eq(Item)
    expect(repo.all[2].id).to eq(3)
  end

  it "can update an item's name, description and unit_price while re-stamping the updated_at with a current timestamp" do
    item1 = Item.new({ id: 1, name: "test", description: "test_description", unit_price: 1, created_at: "8:07pm UTC",
                       updated_at: "2:34pm UTC", merchant_id: 001 })
    item2 = Item.new({ id: 2, name: "test-test", description: "another test description", unit_price: 3,
                       created_at: "12:00am utc", udpated_at: "12:00pm UTC", merchant_id: 001 })
    item3 = Item.new({ id: 3, name: "Test Item 3", description: "test_description", unit_price: 5,
                       created_at: "9:07pm UTC", updated_at: "7:26am UTC", merchant_id: 002 })
    repo = ItemRepository.new([item1, item2, item3])

    repo.update(2,
                { name: "Updated Test-Test", description: "This description is updated", unit_price: 999,
                   })
    expect(repo.all[1].unit_price).to eq(999)
    expect(repo.all[1].description).to eq("This description is updated")
    expect(repo.all[1].updated_at).not_to eq("12:00pm UTC")
  end

  it "can delete an item from the library based on given id" do
    item1 = Item.new({ id: 1, name: "test", description: "test_description", unit_price: 1, created_at: "8:07pm UTC",
                       updated_at: "2:34pm UTC", merchant_id: 001 })
    item2 = Item.new({ id: 2, name: "test-test", description: "another test description", unit_price: 3,
                       created_at: "12:00am utc", udpated_at: "12:00pm UTC", merchant_id: 001 })
    item3 = Item.new({ id: 3, name: "Test Item 3", description: "test_description", unit_price: 5,
                       created_at: "9:07pm UTC", updated_at: "7:26am UTC", merchant_id: 002 })
    repo = ItemRepository.new([item1, item2, item3])

    repo.delete(2)
    expect(repo.all).to eq([item1, item3])
  end
end
