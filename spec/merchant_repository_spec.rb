require './lib/merchant.rb'
require './lib/merchant_repository.rb'

RSpec.describe MerchantRepository do
  context 'instantiation' do
    it 'exists' do
      path = './data/merchants.csv'
      mr = MerchantRepository.new(path)

      expect(mr).to be_a MerchantRepository
    end
  end

  context 'functionality' do
    before :each do
      @mr = MerchantRepository.new('./data/merchants.csv')
    end

    it 'creates Merchant objects' do
      expect(@mr.all).to be_an Array
      expect(@mr.all[0].id).to eq 12334105
      expect(@mr.all[0].name).to eq 'Shopin1901'
    end

    it '#find_by_id' do
      expect(@mr.find_by_id(12334105)).to be_a Merchant
      expect(@mr.find_by_id(12334105).name).to eq 'Shopin1901'
      expect(@mr.find_by_id(12334112).name).to eq 'Candisart'
      expect(@mr.find_by_id(10)).to be nil
    end

    it '#find_by_name' do
      expect(@mr.find_by_name('Candisart')).to be_a Merchant
      expect(@mr.find_by_name('Candisart').id).to eq 12334112
      expect(@mr.find_by_name('cAndisARt').id).to eq 12334112
      expect(@mr.find_by_name('HaewonsDonuts')).to be nil
    end

    it '#find_all_by_name' do
      fragment1 = "a"
      fragment2 = "shop"
      fragment3 = "oiawhge;jweiak;jhfdsioaghwd;"

      expect(@mr.find_all_by_name(fragment1)).to be_an Array
      expect(@mr.find_all_by_name(fragment2).count).to eq 26
      expect(@mr.find_all_by_name(fragment3)).to eq []
    end

    it '#create' do
      attributes1 = {name: 'SamsCatSupplyStore'}
      attributes2 = {id: 12030, name: 'fakestore', created_at: "2021-09-13"}

      merchant1 = @mr.create(attributes1).last
      merchant2 = @mr.create(attributes2).last

      expect(merchant1).to be_a Merchant
      expect(merchant1.id).to eq 12337412
      expect(merchant1.name).to eq 'SamsCatSupplyStore'

      expect(merchant2).to be_a Merchant
      expect(merchant2.id).to eq 12337413
      expect(merchant2.name).to eq 'fakestore'
    end

    it '#update' do
      id = 12334112
      attributes = {id: 10, name: 'Amazon'}
      updated = @mr.update(id, attributes)

      expect(updated.name).to eq 'Amazon'
      expect(updated.id).to eq 12334112
    end

    it '#delete' do
      id = 12334112
      deleted = @mr.delete(id)

      expect(deleted.name).to eq 'Candisart'
      expect(@mr.all).not_to include(deleted)
    end
  end
end
