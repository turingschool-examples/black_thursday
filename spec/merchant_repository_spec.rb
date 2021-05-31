require_relative 'spec_helper'
require_relative '../lib/sales_engine'
require 'csv'
require './lib/merchant_repository'


RSpec.describe MerchantRepository do

  describe 'instantiation' do
    it 'exsits' do
      se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      })
      mr = se.merchants

      expect(mr).to be_an_instance_of(MerchantRepository)
    end
  end


  describe 'methods' do
    it 'can find a merchant by id' do
      se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      })
      mr = se.merchants

      expect(mr.find_by_id(2)).to eq(nil)
      expect(mr.find_by_id(12337411)).to eq()
    end

    it 'can find a merchant by name' do
      se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      })
      mr = se.merchants

      expect(mr.find_by_name("Helen")).to eq(nil)
      expect(mr.find_by_name("CJsDecor")).to eq()
    end

    it 'can find all '

  end
end
