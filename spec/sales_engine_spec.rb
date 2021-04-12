require './lib/sales_engine'

# This tests the SalesEngine class
RSpec.describe 'SalesEngine' do
  describe 'initialize' do
    it 'stores the hash for csv location' do
      se = SalesEngine.from_csv(
        :items => './data/items.csv',
        :merchants => './data/merchants.csv'
      )

      expect(se.class).to eq(SalesEngine)
    end
  end
end
