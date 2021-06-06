require_relative './spec_helper'

RSpec.describe MerchantRepository do
  context 'instantiation' do
    it 'exists' do
      se = SalesEngine.new({ items: 'spec/fixtures/items.csv', merchants: 'spec/fixtures/merchants.csv' })
      mr = MerchantRepository.new('spec/fixtures/merchants.csv', se)
      expect(mr).to be_a(MerchantRepository)
    end
  end

  context 'methods' do
    before :each do
      @se = SalesEngine.new({ items: 'spec/fixtures/items.csv', merchants: 'spec/fixtures/merchants.csv' })
      @mr = MerchantRepository.new('spec/fixtures/merchants.csv', @se)
      @mr.generate
      @merchant1 = @mr.all[1]
      @merchant2 = @mr.all[-1]
    end

    it 'generates merchant instances' do
      expect(@merchant1.id).to eq(0o2)
      expect(@merchant1.name).to eq('Candisart')
      expect(@merchant2.id).to eq(20)
      expect(@merchant2.name).to eq('Madewithgitterxx')
      expect(@mr.all).to be_a(Array)
    end

    it 'returns merchant with matching ID or nil' do
      expect(@mr.find_by_id(0o2)).to eq(@merchant1)
      expect(@mr.find_by_id(20)).to eq(@merchant2)
      expect(@mr.find_by_id(26_866_642)).to eq(nil)
    end

    it 'returns merchant with matching name or nil' do
      expect(@mr.find_by_name('Candisart')).to eq(@merchant1)
      expect(@mr.find_by_name('Madewithgitterxx')).to eq(@merchant2)
      expect(@mr.find_by_name('footballs')).to eq(nil)
    end

    it 'returns merchant with supplied name fragment' do
      expect(@mr.find_all_by_name('Candi')).to eq([@merchant1])
      expect(@mr.find_all_by_name('Madew')).to eq([@merchant2])
      expect(@mr.find_all_by_name('footba')).to eq([])
    end

    it 'creates a new merchant' do
      expect(@mr.new_id).to eq(21)
    end

    it 'creates a new merchant instance with given attributes' do
      attributes = {
        name: "Bob's Airplanes"
      }
      @mr.create(attributes)

      expect(@mr.find_by_id(21).name).to eq("Bob's Airplanes")
      @mr.create(attributes)
      expect(@mr.find_by_id(22).name).to eq("Bob's Airplanes")
    end

    it 'updates merchant by id with given attributes' do
      attributes = {
        name: 'Candismath'
      }
      @mr.update(0o2, attributes)

      expect(@merchant1.name).to eq('Candismath')
    end

    it 'delete merchant by id' do
      expect(@mr.all.length).to eq(20)
      expect(@mr.delete(0o2)).to eq(@merchant1)
      expect(@mr.all.length).to eq(19)
    end

    it 'can inspect rows' do
      expect(@mr.inspect).to eq('#<MerchantRepository 20 rows>')
    end
  end
end
