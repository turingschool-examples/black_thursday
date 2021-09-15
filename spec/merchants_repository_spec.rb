require 'rspec'
require './lib/merchants_repository'
require './.lib/merchant'


describe MerchantsRepository do

  describe '#initialize' do
    it 'is an instance of MerchantsRepository class' do
    merchant_array = []
    @object_1 = Merchant.new({:id => 12334105, :name => "Shopin1901"})
    @object_2 = Merchant.new({:id => 12334112, :name => "Candisart"})
    @object_3 = Merchant.new({:id => 12334113, :name => "MiniatureBikez"})
    merchant_array.push(object_1, object_2, object_3)
    mr = MerchantsRepository.new(merchant_array)
    end

    it 'has readable attributes' do
      merchant_array = []
      expect(mr.all).to be_an Array
    end

    it 'can return merchant by id' do
      expect(mr.find_by_id(id)).to eq()
    end

    it 'can return merchant by name' do
      expect(mr.find_by_name(name)).to eq()
    end

    it 'can find all by name' do
      expect(mr.find_all_by_name(name)).to eq()
    end

    it 'can create attributes' do
    end

    it 'can update the merchant instance' do
    end

    it 'can delete a merchant instance' do
      expect(mr.delete(id)).to eq()
    end
  end
end
