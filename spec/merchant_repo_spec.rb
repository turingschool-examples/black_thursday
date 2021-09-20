# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require './lib/merchant_repository'

RSpec.describe 'MerchantRepository' do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                     items: './data/items.csv',
                                     merchants: './data/merchants.csv',
                                     invoices: './data/invoices.csv'
                                   })
  end
  it '#all' do
    expected = @engine.merchants.all
    expect(expected.count).to eq 475
  end

  it '#find_by_id' do
    id = 12_335_971
    expected = @engine.merchants.find_by_id(id)

    expect(expected.id).to eq(12_335_971)
    expect(expected.name).to eq('ivegreenleaves')
  end

  it '#find_by_id' do
    id = 101
    expected = @engine.merchants.find_by_id(id)

    expect(expected).to eq(nil)
  end

  it '#find_by_name' do
    name = 'Teeforbeardedmen'
    expected = @engine.merchants.find_by_name(name)

    expect(expected.id).to eq(12_335_541)
    expect(expected.name).to eq(name)
  end

  it '#find_by_name' do
    name_2 = 'Teaforbeardedwomen'
    expected = @engine.merchants.find_by_name(name_2)

    expect(expected).to eq(nil)
  end

  it '#find_all_by_name' do
    name = 'Moon'
    name2 = 'style'
    expected = @engine.merchants.find_all_by_name(name)
    expected2 = @engine.merchants.find_all_by_name(name2)
    expect(expected.count).to eq(3)
    expect(expected2.count).to eq(3)
    expect(expected.first.name).to eq('IvyMoonCat')
    expect(expected2.first.name).to eq('justMstyle')
  end

  it '#highest_id' do
    expect(@engine.merchants.highest_id).to eq(12_337_412)
    expected = { name: 'this test' }
    @engine.merchants.create(expected)
    expect(@engine.merchants.highest_id).to eq(12_337_413)
  end

  it '#create' do
    expected = { name: 'this test' }
    @engine.merchants.create(expected)
    expect(@engine.merchants.find_by_id(12_337_412)).to be_a(Merchant)
  end

  it '#updates' do
    expected = { name: 'this test' }
    @engine.merchants.create(expected)
    attributes = {
      name: 'this is another test'
    }
    expected = @engine.merchants.find_by_id(12_337_412)
    @engine.merchants.update(12_337_412, attributes)
    expect(expected.name).to eq('this is another test')
  end

  it '#delete' do
    expected = Merchant.new([111_666_111,
                             'this test',
                             Time.now.strftime('%Y-%m-%d'),
                             Time.now.strftime('%Y-%m-%d')])
    id = 111_666_111
    expect(expected.id).to eq(111_666_111)

    expected = @engine.merchants.delete(id)

    expect(expected).to eq(nil)
  end
end
