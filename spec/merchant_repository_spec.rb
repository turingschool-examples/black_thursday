require 'csv'
require './lib/merchant'
require './lib/merchant_repository'
require 'pry'

describe MerchantRepository do
  merch_rep = MerchantRepository.new('./data/merchants.csv')

  it "exists" do
    expect(merch_rep).to be_an_instance_of(MerchantRepository)
  end

  it "can call all Merchant class instances" do
    expect(merch_rep.all.length).to eq(475)
    expect(merch_rep.all[3].class).to be(Merchant)
  end

  it "can find an instance of Merchant using it's ID" do
    expect(merch_rep.find_by_id('12334319').name).to eq('dansoilpaintings')
    expect(merch_rep.find_by_id('12334189').name).to eq('JacquieMann')
    expect(merch_rep.find_by_id('nothing')).to be_nil
  end

  it "can find an instance of Merchant uwsing it's name" do
    expect(merch_rep.find_by_name('GJGemology')).to eq(merch_rep.all[26])
    expect(merch_rep.find_by_name('SWISSIonenSchmuck')).to eq(merch_rep.all[204])
    expect(merch_rep.find_by_name('nothing')).to be_nil
  end

  it "can find all instances of Merchants with the same name" do
    expect(merch_rep.find_all_by_name('Shopin1901')).to eq([merch_rep.all[0], merch_rep.all[1]])
    expect(merch_rep.find_all_by_name('nothing')).to eq([])
  end

  it "can create new Merchant instances" do
    expect(merch_rep.all[-1].name).to eq('CJsDecor')
    merch_rep.create('Not A Real Merchant')
    expect(merch_rep.all[-1].name).to eq('Not A Real Merchant')
    expect(merch_rep.all[-1].id).to eq('12337412')
  end

  it 'can update a merchants name' do
    expect(merch_rep.all[-1].name).to eq('Not A Real Merchant')
    merch_rep.update('12337412', 'Actually a Real Merchant')
    expect(merch_rep.all[-1].name).to eq('Actually a Real Merchant')
    # binding.pry
  end

  it 'can delete a merchant based on their id' do
    expect(merch_rep.find_by_id('12334319').name).to eq('dansoilpaintings')
    merch_rep.delete('12334319')
    expect(merch_rep.find_by_id('12334319')).to eq(nil)
  end
end
