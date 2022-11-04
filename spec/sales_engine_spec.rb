# frozen_string_literal: true

require 'rspec'
require 'csv'
require './lib/sales_engine'
require './lib/merchant_repository'

describe SalesEngine do
  let(:data) do
    {
      items: './data/items_test.csv',
      merchants: './data/merchants_test.csv'
    }
  end
  let(:se) { SalesEngine.new(data) }

  # describe '#initialize' do
  #   it 'instantiates correctly' do
  #     expect(se).to be_a SalesEngine
  #     expect(se.repository).to eq(
  #       {
  #         items: './data/items_test.csv',
  #         merchants: './data/merchants_test.csv'
  #       }
  #     )
  #   end
  # end

  describe '#self.from_csv' do
    xit 'reads the csv files to supply data to the repositories' do
      se = SalesEngine.from_csv(data)
      i_data = CSV.read './data/items_test.csv', headers: true, header_converters: :symbol
      m_data = CSV.read './data/merchants_test.csv', headers: true, header_converters: :symbol
      expect(se.ir_data).to eq(i_data)
      expect(se.mr_data).to eq(m_data)
    end
  end

  describe '#merchants' do
    xit 'has a MerchantRepository object instance' do
      se = SalesEngine.from_csv(data)
      expect(se.merchants).to be_a MerchantRepository
    end
  end
end
