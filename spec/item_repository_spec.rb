require_relative 'spec_helper'
require 'Rspec'
require_relative '../lib/item_repository'

describe ItemRepository do
  before :each do
    @ir = ItemRepository.new('./data/items.csv')
  end

  it 'is an instance of ItemRepository' do
    expect(@ir).to be_a ItemRepository
  end

  it 'creates an array full of hashes from the csv' do
    expect(@ir.to_array).to be_a Array
    expect(@ir.to_array.empty?).to be false
  end

  it '#all' do
    expect(@ir.all).to be_a Array
    expect(@ir.all.empty?).to be false
    expect(@ir.all[0]).to be_a Item
    expect(@ir.all.length).to eq 1367
  end

  it '#find_by_id' do
    expect(@ir.find_by_id(263395237)).to be_a Item
    expect(@ir.find_by_id(263395617).name).to eq 'Glitter scrabble frames'
    expect(@ir.find_by_id(2)).to eq nil
  end

  it '#find_by_name' do
    expect(@ir.find_by_name('510+ RealPush IcON SeT')).to be_a Item
    expect(@ir.find_by_name('510+ RealPush IcON SeT').id).to eq 263395237
    expect(@ir.find_by_name('')).to eq nil
  end

  it '#find_all_with_description' do
    expect(@ir.find_all_with_description('asdfvds2344')).to eq []
    expect(@ir.find_all_with_description('I have sizes S, M, and L').length).to eq 1
    expect(@ir.find_all_with_description('I have sizes S, M, and L')[0].id).to eq 263407685
  end

  it '#find_all_by_price' do
    expect(@ir.find_all_by_price(-1)).to eq []
    expect(@ir.find_all_by_price(75.00)).to be_a Array
    expect(@ir.find_all_by_price(75.00).empty?).to be false
  end

  it '#find_all_by_price_in_range' do
    expect(@ir.find_all_by_price_in_range(-5..-1)).to eq []
    expect(@ir.find_all_by_price_in_range(0..10.00)).to be_a Array
    expect(@ir.find_all_by_price_in_range(0..10.00).empty?).to be false
  end

  it '#find_all_by_merchant_id' do
    expect(@ir.find_all_by_merchant_id(-1)).to eq []
    expect(@ir.find_all_by_merchant_id(12336642).length).to eq 2
  end

  it '#find_highest_id' do
    expect(@ir.find_highest_id).to be_a Integer
    expect(@ir.find_highest_id).to be > 263567376
  end

  it '#create' do
    attributes = {
      name: 'laptop',
      description: 'This is my old school laptop I used to learn how to code',
      unit_price: 10000,
      created_at: Time.now.utc,
      updated_at: Time.now.utc,
      merchant_id: 9
    }

    @ir.create(attributes)

    expect(@ir.find_by_name('laptop').merchant_id).to eq(9)
    expect(@ir.find_by_id(263567475).name).to eq 'laptop'
  end

  it '#update' do
    info =  {
      name: 'laptop',
      description: 'This is my old school laptop I used to learn how to code',
      unit_price: 10000,
      created_at: Time.now.utc,
      updated_at: Time.now.utc,
      merchant_id: 9
    }

    @ir.create(info)

    attributes = {name: 'desktop'}

    @ir.update(263567475, attributes)

    expect(@ir.find_by_id(263567475).name).to eq('desktop')
  end

  it '#delete' do
    info =  {
      name: 'laptop',
      description: 'This is my old school laptop I used to learn how to code',
      unit_price: 10000,
      created_at: Time.now.utc,
      updated_at: Time.now.utc,
      merchant_id: 9
    }

    @ir.create(info)

    @ir.delete(263567475)

    expect(@ir.find_by_id(263567475)).to eq nil
  end
end
