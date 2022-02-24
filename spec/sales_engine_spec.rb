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

    it 'has / can read merchants' do


      expect(se.merchants).to be("./data/merchants.csv")
    end

    it 'has / can read items' do

      expect(se.items).to be("./data/items.csv")
    end
  end
end
