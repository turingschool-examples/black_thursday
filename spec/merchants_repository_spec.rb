require 'rspec'
require './lib/merchants_repository'
require './lib/merchant'

describe MerchantsRepository do
  before(:each) do
    @merchant_array = []
    @object_1 = Merchant.new({ id: 123_341_05, name: 'Shopin1901' })
    @object_2 = Merchant.new({ id: 123_341_12, name: 'Candisart' })
    @object_3 = Merchant.new({ id: 123_341_13, name: 'MiniatureBikez' })
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
  end

  describe '#find_by_id' do
    it 'can return merchant by id' do
      expect(@mr.find_by_id(123_341_12)).to eq(@object_2)
    end
  end

  describe '#find_by_name' do
    it 'can return merchant by name' do
      expect(@mr.find_by_name('MiniatureBikez')).to eq(@object_3)
    end
  end

  describe '#find_all_by_name' do
    it 'can find all by name' do
      @object_4 = Merchant.new({ :id => 123_341_14, :name => 'MiniatureBikez' })
      @merchant_array.push(@object_4)

      expect(@mr.find_all_by_name('MiniatureBikez')).to eq([@object_3, @object_4])
    end
  end

  describe '#create' do
    it 'can create attributes' do
      @mr.create('TestingCo')
      object_4 = @mr.all[3]
      expect(@mr.all[3]).to eq(object_4)
      expect(@mr.all.last.id).to eq(123_341_14)
    end
  end

  describe '#update' do
    it 'can update the merchant instance' do
      @mr.update('Shopin1901', 'TestingTesting123')

      expect(@object_1.name).to eq('TestingTesting123')
    end
  end

  describe '#delete' do
    it 'can delete a merchant instance' do
      expect(@mr.delete(123_341_12)).to eq(@object_2)
      expect(@mr.all.length).to eq(2)
    end
  end
end
