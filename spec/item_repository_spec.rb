require './lib/sales_engine'

RSpec.describe 'ItemRepository' do
  describe '#initialize' do
    it 'creates an instance of ItemRepository' do
      se = SalesEngine.from_csv(
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
      )

      ir = se.items

      expect(ir.class).to eq(ItemRepository)
    end
  end
end
