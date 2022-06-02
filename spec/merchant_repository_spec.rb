require './lib/merchant.rb'
require './lib/merchant_repository.rb'

RSpec.describe MerchantRepository do
  it 'exists' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo).to be_a(MerchantRepository)
  end

  it 'returns an array of all known Merchant instances' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo.all.count).to eq(475)
  end

  it 'can find merchant by ID' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo.find_by_id(12334105)).to be_a(Merchant)
    expect(merchant_repo.find_by_id(12948129048)).to eq(nil)
  end

  it 'can find merchant by name' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo.find_by_name('Shopin1901')).to be_instance_of(Merchant)
    expect(merchant_repo.find_by_name('sHoPiN1901')).to be_instance_of(Merchant)
    expect(merchant_repo.find_by_name('InvalidName')).to eq(nil)
  end

  it 'can find all merchants by name fragment' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo.find_all_by_name('mini')).to be_instance_of(Array)
    expect(merchant_repo.find_all_by_name('MiNi')).to be_instance_of(Array)
    expect(merchant_repo.find_all_by_name('inG')).to be_instance_of(Array)
    expect(merchant_repo.find_all_by_name('sHoPiN')).to be_instance_of(Array)
    expect(merchant_repo.find_all_by_name('sHoPiN1901')).to be_instance_of(Array)
    expect(merchant_repo.find_all_by_name('InvalidName')).to eq([])
  end

  #Nick and Thiago left off here, need to ask if lines 30 - 32 are valid tests
end
