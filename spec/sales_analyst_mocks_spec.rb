require 'rspec'
require './data/mock_data'
require './lib/sales_analyst'
require './spec/sales_analyst_mocks'

RSpec.describe SalesAnalystMocks do
  describe '#sales_engine_mock' do
    it 'returns a mocked sales engine' do
      sales_engine_mock = SalesAnalystMocks.sales_engine_mock(self)
      expect(sales_engine_mock).not_to eq nil
    end
  end
end
