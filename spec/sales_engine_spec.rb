require_relative 'spec_helper'

RSpec.describe SalesEngine do
  describe 'instantiation' do
    it 'exists' do
      paths = {
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
      }
      sales_engine = SalesEngine.new(paths)

      expect(sales_engine).to be_a(SalesEngine)
    end
  end
end
