require 'SimpleCov'
SimpleCov.start

require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

RSpec.describe MerchantRepository do
  before :each do
    @mr = MerchantRepository.new('./spec/fixture_files/merchant_fixture.csv')
  end

  it 'exists' do
    expect(@mr).to be_an_instance_of(MerchantRepository)
  end

  it 'can create item objects' do
    expect(@mr.all[0]).to be_an_instance_of(Merchant)
  end

  it 'returns a list of known merchants' do
    expect(@mr.all.count).to eq(3)
  end

  it 'returns a merchant with a matching id' do
    expected = @mr.find_by_id(5)

    expect(expected.id).to eq(5)
    expect(expected.name).to eq('Turing School')
  end

  it 'returns a merchant by name' do
    expected  = @mr.find_by_name('TuRing ScHool')

    expect(expected.name).to eq('Turing School')
  end

  it 'returns all merchants by name' do
    expected = @mr.find_all_by_name('Turing School')
    expected2 = @mr.find_all_by_name('Something Else')

    expect(expected.count).to eq(1)
    expect(expected2.count).to eq(2)
  end

  it 'creates a new merchant with attributes' do
    attributes = { :name => 'Another Merchant' }

    @mr.create(attributes)
    expected = @mr.find_by_id(8)

    expect(@mr.all.count).to eq(4)
    expect(expected.name).to eq('Another Merchant')
  end

  it 'finds merchant by id and updates name' do
    attributes = { :name => 'Another Merchant' }

    @mr.update(5, attributes)
    expected = @mr.find_by_id(5)

    expect(expected.name).to eq('Another Merchant')
  end

  it 'finds and deletes merchant by id' do
    @mr.delete(6)

    expect(@mr.all.count).to eq(2)
  end
end
