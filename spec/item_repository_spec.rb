require_relative '../lib/item_repository'
require 'simplecov'
SimpleCov.start

RSpec.describe ItemRepository do
  before(:each) do
    @item_repo = ItemRepository.new('./data/items.csv')
  end

  it '#initialize' do
    expect(@item_repo.filename).to eq('./data/items.csv')
  end

  it 'can read #items' do

    expect(@item_repo.items).to be_a(Array)
  end

  it '#all' do
    expect(@item_repo.all).to be_a(Array)
  end

  it '#rows' do
    expect(@item_repo.rows).to be_a(CSV::Table)

  end

  it 'can #find_by_id(id)' do
    expect(@item_repo.find_by_id("263395237")).to be_a(Item)
    expect(@item_repo.find_by_id("288888887")).to eq(nil)
  end

  it 'can #find_by_name(name)' do

    expect(@item_repo.find_by_name("Glitter scrabble frames")).to be_a(Item)
    expect(@item_repo.find_by_name("blah blah blah")).to eq(nil)
  end

  it 'can #find_all_with_description(description)' do
    item_1 = @item_repo.find_all_with_description('standing wooden')
    expect(item_1.count).to eq(1)
    expect(@item_repo.find_all_with_description('standing wooden')).to be_a(Array)
    expect(@item_repo.find_all_with_description('no shot this is a description')).to eq([])
  end

  it 'can #find_all_by_price(price)' do
    item = @item_repo.find_all_by_price("2999")
    expect(item.count).to eq(3)
    expect(@item_repo.find_all_by_price("2999")).to be_a(Array)
  end

  it 'can #find_all_by_price_in_range(range)' do
    # require "pry"; binding.pry
    item_2 = @item_repo.find_all_by_price_in_range(1..3000)
    expect(item_2.count).to eq(735)
  end

  it 'can #find_all_by_merchant_id(merchant_id)' do
    item_3 = @item_repo.find_all_by_merchant_id("12334195")
    expect(item_3.count).to eq(20)
  end

  it 'can #create(attributes)' do

    item_4 = @item_repo.create({:id => '1',
                                :name => "Pencil",
                                :description => "You can use it to write things",
                                :unit_price => BigDecimal(10.99,4),
                                :created_at => Time.now,
                                :updated_at => Time.now,
                                :merchant_id => 2})
    expect(item_4).to be_a(Item)
    expect(@item_repo.items[-1]).to eq(item_4)
    
  end

  it 'can #update(id, attributes)' do
    item_5 = @item_repo.create({:id => '1',
                                :name => "Pencil",
                                :description => "You can use it to write things",
                                :unit_price => BigDecimal(10.99,4),
                                :created_at => Time.now,
                                :updated_at => Time.now,
                                :merchant_id => 2})
    item_5 = @item_repo.update("263567475", {:name => 'Eraser', :description => "It erases things", :unit_price => BigDecimal(10.88,4)})
    expect(item_5.name).to eq('Eraser')
    expect(item_5.description).to eq("It erases things")
    expect(item_5.unit_price).to eq(BigDecimal(10.88,4))


  end



end
