require_relative '../lib/sales_engine'
require_relative 'spec_helper'
require 'pry'

RSpec.describe SalesEngine do
let(:se) {SalesEngine.from_csv({:items=> "./data/items.csv", :merchants => "./data/merchants.csv",})}
  describe 'items and merchants' do
    it 'exists' do
      sales_engine = SalesEngine.new

      expect(sales_engine).to be_a(SalesEngine)
    end

    it 'has / can read item info' do

      expect(se[0].count).to be(1367)
    end

    it 'has / can read merchant info' do

      expect(se[1].count).to be(475)
    end
  end
end
