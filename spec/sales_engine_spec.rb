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
end
