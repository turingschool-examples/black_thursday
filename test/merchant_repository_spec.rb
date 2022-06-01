require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  before :each do
    @filepath = './data/merchants.csv'
    @collection = MerchantRepository.new(@filepath)
  end

  describe '#initialize' do
    it 'is a MerchantRepository' do
      expect(@collection).to be_a MerchantRepository
    end

    it 'can return an array of all known Merchant instances' do
      expect(@collection.all).to be_a Array
      expect(@collection.all.count).to eq 475
      expect(@collection.all.first).to be_a Merchant
      expect(@collection.all.first.id).to eq '12334105'
    end
  end

  describe '#find_by_id' do
    it 'can find a merchant by id' do
      expect(@collection.find_by_id('8675309')).to eq nil
      expect(@collection.find_by_id('12334105')).to be_a Merchant
      expect(@collection.find_by_id('12334105').name).to eq 'Shopin1901'
    end
  end

  describe '#find_by_name' do
    it 'can find a merchant by name' do
      expect(@collection.find_by_name('my big fancy shop!')).to eq nil
      expect(@collection.find_by_name('Shopin1901')).to be_a Merchant
      expect(@collection.find_by_name('Shopin1901').name).to eq 'Shopin1901'
      expect(@collection.find_by_name('Shopin1901').id).to eq '12334105'
    end
  end

end
