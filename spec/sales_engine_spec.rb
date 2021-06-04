require 'spec_helper'

RSpec.describe SalesEngine do
  describe 'instantiation' do
    it 'exists' do
      library = ({
        :items     => "./data/items.csv"
        # :merchants => "./data/merchants.csv"
      })
      sales_engine = SalesEngine.new(library)

      expect(sales_engine).to be_a(SalesEngine)
    end

  end
end
