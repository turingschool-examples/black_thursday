require './lib/sales_analyst'

RSpec.describe 'SalesAnalyst' do
  describe '#initialize' do
    it 'creates an instance of SalesAnalyst'do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa).to be_an_instance_of(SalesAnalyst)
    end
    it 'is passed attributes' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.merchants).to be_an_instance_of(MerchantRepository)
      expect(sa.items).to be_an_instance_of(ItemRepository)
    end
  end
end
