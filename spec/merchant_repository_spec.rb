require 'SimpleCov'
SimpleCov.start

require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

RSpec.describe MerchantRepository do
  it 'exists' do
    mr = MerchantRepository.new("./spec/fixture_files/merchant_fixture.csv")

    expect(mr).to be_an_instance_of(MerchantRepository)
  end

  it 'can create item objects' do
    mr = MerchantRepository.new("./spec/fixture_files/merchant_fixture.csv")

    expect(mr.all[0]).to be_an_instance_of(Merchant)
  end

  it 'returns a list of known merchants' do
    mr = MerchantRepository.new("./spec/fixture_files/merchant_fixture.csv")
    expect(mr.all.count).to eq(3)
  end

  it 'returns a merchant with a matching id' do
    mr = MerchantRepository.new("./spec/fixture_files/merchant_fixture.csv")
    expected = mr.find_by_id(5)

    expect(expected.id).to eq(5)
    expect(expected.name).to eq("Turing School")
  end

  it 'returns a merchant by name' do
    mr = MerchantRepository.new("./spec/fixture_files/merchant_fixture.csv")
    expected  = mr.find_by_name("TuRing ScHool")

    expect(expected.name).to eq("Turing School")
  end

  it 'returns all merchants by name' do
    mr = MerchantRepository.new("./spec/fixture_files/merchant_fixture.csv")
    expected = mr.find_all_by_name("Turing School")
    expected2 = mr.find_all_by_name("Something Else")

    expect(expected.count).to eq(1)
    expect(expected2.count).to eq(2)
  end

  it 'creates a new merchant with attributes' do
    mr = MerchantRepository.new("./spec/fixture_files/merchant_fixture.csv")
    mr.create("Another Merchant")
    expected = mr.find_by_id(8)

    expect(mr.all.count).to eq(4)
    expect(expected.name).to eq("Another Merchant")
  end

  it 'finds merchant by id and updates name' do
    mr = MerchantRepository.new("./spec/fixture_files/merchant_fixture.csv")
    mr.update(5, "Turing School of Coding")
    expected = mr.find_by_id(5)

    expect(expected.name).to eq("Turing School of Coding")
  end

  it "finds and deletes merchant by id" do
    mr = MerchantRepository.new("./spec/fixture_files/merchant_fixture.csv")
    mr.delete(6)

    expect(mr.all.count).to eq(2)
  end
end
