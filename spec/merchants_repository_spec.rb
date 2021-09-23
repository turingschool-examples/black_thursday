# frozen_string_literal: true

require 'SimpleCov'
SimpleCov.start

require 'rspec'
require './lib/merchants_repository'

describe MerchantsRepository do
  before(:each) do
    @mr = MerchantsRepository.new('./data/merchant_test.csv')
  end

  describe '#initialize' do
    it 'is an instance of MerchantsRepository class' do
      expect(@mr).to be_an_instance_of MerchantsRepository
    end

    it 'can return all merchants' do
      expect(@mr.all).to be_an Array
      expect(@mr.all).to eq([@mr.all[0], @mr.all[1], @mr.all[2]])
    end
  end

  describe '#find_by_id' do
    it 'can return merchant by id' do
      expect(@mr.find_by_id(123_341_12)).to eq(@mr.all[1])
    end
  end

  describe '#find_by_name' do
    it 'can return merchant by name' do
      expect(@mr.find_by_name('MiniatureBikez')).to eq(@mr.all[2])
    end
  end

  describe '#find_all_by_name' do
    it 'can find all by name' do
      @object4 = Merchant.new(id: 123_341_14, name: 'MiniatureBikez')
      @mr.all.push(@object4)

      expect(@mr.find_all_by_name('MiniatureBikez')).to eq([@mr.all[2], @object4])
    end
  end

  describe '#create' do
    it 'can create attributes' do
      attributes = {
        name: 'TestingCo'
      }
      @mr.create(attributes)
      object4 = @mr.all[3]
      expect(@mr.all[3]).to eq(object4)
      expect(@mr.all.last.id).to eq(123_341_14)
    end
  end

  describe '#update' do
    it 'can update the merchant instance' do
      attributes = {
        name: 'TestingTesting123',
        id: '123_321_123'
      }
      @mr.update(123_341_05, attributes)

      expect(@mr.all[0].name).to eq(attributes[:name])
      expect(@mr.all[0].id).to eq(123_341_05)
    end
  end

  describe '#delete' do
    it 'can delete a merchant instance' do
      deleted_item = @mr.all[1]
      expect(@mr.delete(123_341_12)).to eq(deleted_item)
      expect(@mr.all.length).to eq(2)
    end
  end
end
