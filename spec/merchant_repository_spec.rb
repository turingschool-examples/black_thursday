# merchant_rep_spec
require_relative 'merchant_repository'
require_relative 'merchant'
require 'pry'

RSpec.describe MerchantRepository do
  before(:each) do
    @se = SalesEngine.from_csv({
                                 items: './data/items.csv',
                                 merchants: './data/merchants.csv'
                               })
  end

  it 'exists' do
    expect(@se.merch_repo).to be_a(MerchantRepository)
  end

  it 'can return an array of #all elements within the merchant.csv file' do
    expect(@se.merch_repo.all.length).to eq(475)
  end

  it 'can find a merchant using id' do
    id = 12_334_159
    expected = @se.merch_repo.find_by_id(12_334_159)
    expect(expected.name).to eq('SassyStrangeArt')
  end

  it '#find by id returns nil on merch does not exist' do
    id = 1
    expected = @se.merch_repo.find_by_id(id)

    expect(expected).to eq(nil)
  end

  it 'can #find_by_name merchant' do
    name = 'SassyStrangeArt'
    expected = @se.merch_repo.find_by_name(name)

    expect(expected.id).to eq(12_334_159)
  end

  it '#find_by_name is case insensitive' do
    name = 'sassystrangeart'
    expected = @se.merch_repo.find_by_name(name)

    expect(expected.id).to eq(12_334_159)
  end

  it '#find_by_name returns nil when merchant does not exist' do
    name = 'SassyStrange'
    expected = @se.merch_repo.find_by_name(name)

    expect(expected).to eq(nil)
  end

  it '#find_all_by_name finds all merchants matching fragment' do
    fragment = 'shop'
    expected = @se.merch_repo.find_all_by_name(fragment)
    expect(expected.length).to eq(26)
    expect(expected.map(&:name).include?('thepurplepenshop')).to eq true
    expect(expected.map(&:id).include?(12_334_176)).to eq(true)
  end

  it '#find_all_by_name returns empty array when no merchants' do
    name = 'AngryClownDayCare'
    expected = @se.merch_repo.find_all_by_name(name)

    expect(expected).to eq([])
  end

  it 'can #create a new merchant instance' do
    attributes = { name: 'AngryClownDayCare', created_at: Time.now,
                   updated_at: Time.now }

    @se.merch_repo.create(attributes)
    expected = @se.merch_repo.find_by_id(12_337_412)
    expect(expected.name).to eq('AngryClownDayCare')
  end

  it '#update updates a merchant' do
    attributes = {
      name: "Vlad's Variety Store"
    }
    @se.merch_repo.update(12_336_050, attributes)
    expected = @se.merch_repo.find_by_id(12_336_050)
    expect(expected.name).to eq "Vlad's Variety Store"
    expected = @se.merch_repo.find_by_name('Intricate Sunset')
    expect(expected).to eq nil
  end

  it '#update cannot update id' do
    attributes = {
      id: 42
    }
    @se.merch_repo.update(12_337_412, attributes)
    expected = @se.merch_repo.find_by_id(42)
    expect(expected).to eq nil
  end

  it '#delete deletes the specified merchant' do
    @se.merch_repo.delete(12_336_622)
    expected = @se.merch_repo.find_by_id(12_336_622)
    expect(expected).to eq nil
  end
end
