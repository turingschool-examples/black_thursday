require 'simplecov'
SimpleCov.start
require './lib/item_repository'
require 'rspec'

RSpec.describe ItemRepository do
  it "exists" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    expect(item_repo).to be_a(ItemRepository)
  end

  it "has attributes" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    expect(item_repo.file_path).to eq('./spec/fixtures/item_fixtures.csv')
    expect(item_repo.items).to eq([])
  end

  it "creates repos" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    item_repo.create_repo

    expect(item_repo.items.count).to eq(12)
  end

  it "shows all" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    item_repo.create_repo

    expect(item_repo.all.count).to eq(12)
  end

  it "finds by id" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    item_repo.create_repo

    expect(item_repo.find_by_id(263408574).name).to eq("Adidas Azteca Fußballschuh")
  end

  it "finds by name" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    item_repo.create_repo

    expect(item_repo.find_by_name("Adidas Azteca Fußballschuh").id).to eq(263408574)
  end

  it "finds all with description" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    item_repo.create_repo

    expect(item_repo.find_all_with_description("Adidas Azteca mit Schraubstollen und silbernen Streifen. Hergestellt ab dem Jahr 1986.").count).to eq(2)
  end

  it "finds all by price" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    item_repo.create_repo

    expect(item_repo.find_all_by_price(BigDecimal(75)).length).to eq(4)
  end

  it "finds all prices by range" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    item_repo.create_repo

    expect(item_repo.find_all_by_price_in_range(50.00..100.00).length).to eq(6)
    expect(item_repo.find_all_by_price_in_range(0.00..49.99).length).to eq(3)
    expect(item_repo.find_all_by_price_in_range(101.00..1000.00).length).to eq(3)
  end

  it "finds all by merchant id" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    item_repo.create_repo

    expect(item_repo.find_all_by_merchant_id(12334123).length).to eq(9)
  end

  it "can create an item" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    item_repo.create_repo
    item_repo.create({
      name: "Wings",
      description: "hot, lemon pepper",
      unit_price: "2000",
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: "12334727"
      })
    expect(item_repo.find_by_id(263409022).name).to eq("Wings")
  end

  it "can update an item" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    item_repo.create_repo
    item_repo.create({
      name: "Wings",
      description: "hot, lemon pepper",
      unit_price: "2000",
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: "12334727"
      })

    item_repo.update(263409022,{unit_price: "3000"})

    expect(item_repo.find_by_id(263409022).updated_at.to_i).to eq (Time.now).to_i
  end

  it "can delete an item" do
    mock_engine = double("sales_engine")
    item_repo = ItemRepository.new('./spec/fixtures/item_fixtures.csv', mock_engine)

    item_repo.create_repo
    item_repo.delete(263408355)

    expect(item_repo.find_by_id(263408355)).to eq(nil)
  end
end
