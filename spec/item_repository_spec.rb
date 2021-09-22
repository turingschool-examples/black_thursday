require './lib/item_repository'

RSpec.describe ItemRepository do
  it "exists" do
    items_path = './data/items.csv'
    item_repository = ItemRepository.new(items_path)
    expect(item_repository).to be_an_instance_of(ItemRepository)
  end

  it 'can return an array of all known items' do
    items_path = './data/items.csv'
    item_repository = ItemRepository.new(items_path)

    expect(item_repository.all[0]).to be_an_instance_of(Item)
    expect(item_repository.all.count).to eq 1367# real number goes here
  end

  it 'can find item by id' do
    items_path = './data/items.csv'
    item_repository = ItemRepository.new(items_path)
    example_item = item_repository.all[25]

    expect(item_repository.find_by_id(example_item.id)).to eq example_item
    expect(item_repository.find_by_id(999999)).to eq nil
  end

  it 'can find item by name' do
    items_path = './data/items.csv'
    item_repository = ItemRepository.new(items_path)
    example_item = item_repository.all[25]

    expect(item_repository.find_by_name(example_item.name)).to eq example_item
    expect(item_repository.find_by_name("Item Repellat Dolorum")).to eq nil
  end

  it 'can find all items with descriptions' do
    items_path = './data/items.csv'
    item_repository = ItemRepository.new(items_path)
    example_item = item_repository.all[25]

    expect(item_repository.find_all_with_description(example_item.description)).to eq [example_item]
    expect(item_repository.find_all_with_description("Item Repellat Dolorum")).to eq([])
  end

  it 'can find all by price' do
    items_path = './data/items.csv'
    item_repository = ItemRepository.new(items_path)
    example_item = item_repository.all[566]

    expect(item_repository.find_all_by_price(example_item.unit_price)).to eq [example_item]
    expect(item_repository.find_all_by_price("Item Repellat Dolorum")).to eq([])
  end

  it "can find all by price in range" do
    items_path = './data/items.csv'
    item_repository = ItemRepository.new(items_path)
    example_item = item_repository.all[61]

    expect(item_repository.find_all_by_price_in_range(1..2)).to eq([])
    expect(item_repository.find_all_by_price_in_range(0..20)).to eq([example_item])

  end

  it "can find all by merchant id" do
    items_path = './data/items.csv'
    item_repository = ItemRepository.new(items_path)
    example_item = item_repository.all[25]

    #example_item.merchant_id => 12334365    12334365 is being passed as the argument below
    expect(item_repository.find_all_by_merchant_id(example_item.merchant_id)).to be_an(Array)
    #there are 9 items that match merchant_id 12334365. Counted # of items in array for 2nd test.
    expect(item_repository.find_all_by_merchant_id(example_item.merchant_id).count).to eq(9)
    expect(item_repository.find_all_by_merchant_id(00000000)).to eq([])
  end
end
