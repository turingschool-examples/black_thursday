require './test/spec_helper'


RSpec.describe MerchantRepository do

  before :each do
    @merchantrepository= MerchantRepository.new("./data/merchants.csv")
  end

  it 'exists' do

    expect(@merchantrepository).to be_a(MerchantRepository)
  end

  it 'returns an array of all known merchants' do

    expect(@merchantrepository.all.class).to eq(Array)
    expect(@merchantrepository.all[0].class).to eq(Merchant)
    expect(@merchantrepository.all.count).to eq(475)
  end

  it 'returns either nil or an instance of Merchant with a matching ID' do

    expect(@merchantrepository.find_by_id(12334132).name).to eq("perlesemoi")
    expect(@merchantrepository.find_by_id(123456)).to eq(nil)
    expect(@merchantrepository.find_by_id(12334132)).to be_a(Merchant)

  end

  it 'returns either nil or an instance of Merchant with a name' do

    expect(@merchantrepository.find_by_name("MiniatureBikez")).to be_a(Merchant)
    expect(@merchantrepository.find_by_name("AndreBikez")).to eq(nil)

  end

  it 'returns one or more matches when searching by fragmented name' do
    fragment = "shop"
    expected = @merchantrepository.find_all_by_name(fragment)
    #
    # # expect(expected.length).to eq(5)
    expect(expected.map(&:name).include?("SimchaCentralShop")).to eq true
    expect(expected.map(&:id).include?(12334863)).to eq true
    expect(@merchantrepository.find_all_by_name("shop")[9].name.include?("SimchaCentralShop")).to eq(true)
  end

  it 'can create a new Merchant' do

    @merchantrepository.create("TuringForLife")

    expect(@merchantrepository.all[-1].name).to eq("TuringForLife")
    expect(@merchantrepository.all[-1].id).to eq(12337412)
  end

  it 'update the name' do
    @merchantrepository.create("TuringForLife")

    expect(@merchantrepository.update(12337412, "TuringForLife")).to eq("TuringForever")
  end

end
