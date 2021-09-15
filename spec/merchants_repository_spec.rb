require 'rspec'
require './lib/merchants_repository'
require './lib/merchant'


describe MerchantsRepository do
  before(:each) do
    @merchant_array = []
    @object_1 = Merchant.new({:id => 12334105, :name => "Shopin1901"})
    @object_2 = Merchant.new({:id => 12334112, :name => "Candisart"})
    @object_3 = Merchant.new({:id => 12334113, :name => "MiniatureBikez"})
    @merchant_array.push(@object_1, @object_2, @object_3)
    @mr = MerchantsRepository.new(@merchant_array)
  end

  describe '#initialize' do
    it 'is an instance of MerchantsRepository class' do
      expect(@mr).to be_an_instance_of MerchantsRepository
    end

    it 'can return all merchants' do
      expect(@mr.all).to be_an Array
      expect(@mr.all).to eq([@object_1, @object_2, @object_3])
    end

    it 'can return merchant by id' do
      expect(@mr.find_by_id(12334112)).to eq(@object_2)
    end

    it 'can return merchant by name' do
      expect(@mr.find_by_name("MiniatureBikez")).to eq(@object_3)
    end

    it 'can find all by name' do
      @object_4 = Merchant.new({:id => 12334114, :name => "MiniatureBikez"})
      @merchant_array.push(@object_4)

      expect(@mr.find_all_by_name("MiniatureBikez")).to eq([@object_3, @object_4])
    end

    it 'can create attributes' do
      expect(@mr.create("TestingCo")).to eq({:id => 12334114, :name => "TestingCo"})
    end

    xit 'can update the merchant instance' do
    end

    xit 'can delete a merchant instance' do
      expect(mr.delete(id)).to eq()
    end
  end
end
