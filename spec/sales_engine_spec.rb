# frozen_string_literal: true

require 'rspec'
require 'csv'
require './lib/sales_engine'

describe SalesEngine do
  let(:data) do
    {
      items: './data/items_test.csv',
      merchants: './data/merchants_test.csv'
    }
  end
  let(:se) { SalesEngine.new(data) }

  describe '#initialize' do
    it 'instantiates correctly' do
      expect(se).to be_a SalesEngine
      expect(se.repository).to eq(
        {
          items: './data/items_test.csv',
          merchants: './data/merchants_test.csv'
        }
      )
    end
  end

  describe '#self.from_csv' do
    it 'reads the csv files to supply data to the repositories' do
      se = SalesEngine.from_csv(
        {
          items: './data/items_test.csv',
          merchants: './data/merchants_test.csv'
        }
      )

      expect(se.items).to eq("")
      expect(se.merchants).to eq("")
    end
  end

  describe '#merchants' do
    it 'creates a MerchantRepository instance' do
      mr = se.merchants
      expect(mr).to be_a MerchantRepository
    end
  end
end
