# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require './lib/item_repository'

RSpec.describe do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                     items: './data/items.csv',
                                     merchants: './data/merchants.csv',
                                     invoices: './data/invoices.csv'
                                   })
  end
  it 'exists' do
    expect(@engine.items).to be_an_instance_of(ItemRepository)
  end

  it '#all' do
    expect(@engine.items.all.count).to eq(1367)
  end

  it '#find_by_id' do
    results = @engine.items.find_by_id(263_567_474)
    results2 = @engine.items.find_by_id('Camping Chair Actor')
    expect(results.id).to eq(263_567_474)
    expect(results.unit_price).to eq(38.0)
    expect(results2).to eq(nil)
  end

  it '#find_by_name' do
    results = @engine.items.find_by_name('510+ RealPush Icon Set')
    results2 = @engine.items.find_by_name('Tea For Bearded Women')
    expect(results.id).to eq(263_395_237)
    expect(results.id).to eq(263_395_237)
    expect(results.unit_price).to eq(12.0)
    expect(results2).to eq(nil)
  end

  it '#find_all_with_description' do
    results =  @engine.items.find_all_with_description('Free standing')
    results2 = @engine.items.find_all_with_description('adfadf')
    expect(results.first.id).to eq(263_396_013)
    expect(results.first.unit_price).to eq(7.0)
    expect(results2).to eq([])
  end

  it '#find_all_by_price' do
    results = @engine.items.find_all_by_price(13.0)
    expect(results.first.merchant_id).to eq(12_334_185)
    expect(results.first.id).to eq(263_395_617)
    results2 = @engine.items.find_all_by_price(0.000001)
    expect(results2).to eq([])
  end

  it '#find_all_by_price_in_range' do
    results = @engine.items.find_all_by_price_in_range(13.0..18.0)
    expect(results.first.id).to eq(263_395_617)
  end

  it '#find_all_by_merchant_id' do
    results = @engine.items.find_all_by_merchant_id(12_336_851)
    results2 = @engine.items.find_all_by_merchant_id(12_334_123)
    expect(results.count).to eq(3)
    expect(results2.count).to eq(25)
  end

  it '#highest_id' do
    expect(@engine.items.highest_id).to eq(263_567_475)
    results = @engine.items.create({
                                     name: 'Capita Defenders of Awesome 2018',
                                     description: 'This board both rips and shreds',
                                     unit_price: BigDecimal(399.99, 5),
                                     created_at: Time.now.to_s,
                                     updated_at: Time.now.to_s,
                                     merchant_id: 25
                                   })
    expect(@engine.items.highest_id).to eq(263_567_476)
  end

  it '#create' do
    results = @engine.items.create({
                                     name: 'Capita Defenders of Awesome 2018',
                                     description: 'This board both rips and shreds',
                                     unit_price: BigDecimal(399.99, 5),
                                     created_at: Time.now.to_s,
                                     updated_at: Time.now.to_s,
                                     merchant_id: 25
                                   })
    expect(results.last.id).to eq(263_567_475)
  end

  it '#update' do
    results = @engine.items.create({
                                     name: 'Capita Defenders of Awesome 2018',
                                     description: 'This board both rips and shreds',
                                     unit_price: BigDecimal(399.99, 5),
                                     created_at: Time.now.to_s,
                                     updated_at: Time.now.to_s,
                                     merchant_id: 25
                                   })

    update = @engine.items.update(263_567_475,
                                  { unit_price: BigDecimal(379.99, 5) })
    expect(results.last.unit_price).to eq(379.99)
  end

  it '#delete' do
    @engine.items.delete(263_567_474)
    expected = @engine.items.find_by_id(263_567_474)
    expect(expected).to eq(nil)
  end
end
