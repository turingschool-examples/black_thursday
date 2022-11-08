# frozen_string_literal: true

require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/sales_engine'
require 'spec_helper_2'
require 'pry'

RSpec.describe ItemRepository do
  let(:item_repo) { engine.items }
  it 'exists' do
    expect(item_repo).to be_a(ItemRepository)
  end

  it 'returns an array of all known Item instances' do
    expect(item_repo.all).to be_a(Array)
  end

  it 'finds by id, returns nil otherwise' do
    expect(item_repo.find_by_id(263_395_237)).to eq(item_repo.all.first)
    expect(item_repo.find_by_id(263_567_474)).to eq(item_repo.all.last)
    expect(item_repo.find_by_id(263_395_617)).to eq(item_repo.all[1])
    expect(item_repo.find_by_id(999_999_999)).to eq(nil)
    expect(item_repo.find_by_id(263_395_237)).to be_a(Item)
  end

  it 'finds by name (case insensitive), returns nil otherwise' do
    expect(item_repo.find_by_name('510+ RealPush Icon Set')).to eq(item_repo.all.first)
    expect(item_repo.find_by_name('510+ reAlPUSh IcoN seT')).to eq(item_repo.all.first)
    expect(item_repo.find_by_name('Glitter scrabble frames')).to eq(item_repo.all[1])
    expect(item_repo.find_by_name('GLITter SCRAbbLe fraMES')).to eq(item_repo.all[1])
    expect(item_repo.find_by_name('XXXXXXXXXX')).to eq(nil)
    expect(item_repo.find_by_name('510+ RealPush Icon Set')).to be_a(Item)
  end

  it 'finds all instances given a description (case insensitive), returns empty array otherwise' do
    item1 = item_repo.find_all_with_description('Disney')
    item2 = item_repo.find_all_with_description('diSNeY')
    item3 = item_repo.find_all_with_description('XXXXXXXXX')

    expect(item1.count).to eq(5)
    expect(item2.count).to eq(5)
    expect(item1.first.id).to eq(263_395_721)
    expect(item2.first.id).to eq(263_395_721)
    expect(item3).to eq([])
    expect(item1).to be_a(Array)
    expect(item2).to be_a(Array)
  end

  it 'finds items with exact price given, returns empty array otherwise' do
    item1 = item_repo.find_all_by_price(13.00)
    item2 = item_repo.find_all_by_price(13.50)
    item3 = item_repo.find_all_by_price(99.99)

    expect(item1.count).to eq(8)
    expect(item2.first.id).to eq(263_395_721)
    expect(item3).to eq([])
    expect(item1).to be_a(Array)
  end

  it 'finds item within a given price range, returns empty array otherwise' do
    item1 = item_repo.find_all_by_price_in_range(13.00..13.60)
    item2 = item_repo.find_all_by_price_in_range(0.01..0.05)

    expect(item1.count).to eq(9)
    expect(item1.first.id).to eq(263_395_617)
    expect(item1[7].id).to eq(263_546_142)
    expect(item2).to eq([])
    expect(item1).to be_a(Array)
  end

  it 'finds item with matching merchant ID, returns empty array otherwise' do
    item1 = item_repo.find_all_by_merchant_id(12_334_105)
    item2 = item_repo.find_all_by_merchant_id(11_111_111)

    expect(item1.count).to eq(3)
    expect(item1.first.id).to eq(263_396_209)
    expect(item2).to eq([])
    expect(item1).to be_a(Array)
  end

  it 'can create a new item' do
    items_pre = item_repo.all.length
    attributes = {
      name: 'Colorado Sweater',
      description: 'Perfect sweater for Colorado weather',
      unit_price: 50,
      merchant_id: 3_487_283
    }
    item_repo.create(attributes)
    expect(item_repo.all.last.id).to eq(263_567_474 + 1)
    expect(items_pre).to eq(item_repo.all.length - 1)
  end

  it 'can update an item' do
    attributes = {
      name: 'Colorado Sweater',
      description: 'Perfect sweater for Colorado weather',
      unit_price: 50,
      merchant_id: 3_487_283
    }
    item_repo.update(263_395_617, attributes)
    expect(item_repo.find_by_id(263_395_617).name).to eq('Colorado Sweater')
  end

  it 'can delete an item' do
    item_repo.delete(263_395_617)
    expect(item_repo.find_by_id(263_395_617)).to eq(nil)
  end

  it 'can find an item by name' do
    expect(item_repo.find_all_by_name('Disney scrabble frames')[0].id).to eq(263_395_721)
  end
end
