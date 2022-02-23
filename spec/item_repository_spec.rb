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

  it 'can find_all_with_description(description)' do
    expect(@item_repo.find_all_with_description('standing wooden')).to be_a(Array)
  end

end
