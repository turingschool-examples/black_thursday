require 'csv'
require './lib/sales_engine'

RSpec.describe 'SalesEngine' do
  describe 'initialize' do
    it 'stores the hash for csv location' do
      se = SalesEngine.from_csv(
        :items => './data/items.csv',
        :merchants => './data/merchants.csv',
      )

      expect(se.class).to eq(SalesEngine)
    end
  end
end
