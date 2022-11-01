require './lib/salesanalyst'
require './lib/salesengine'

RSpec.describe SalesAnalyst do
  let(:sales_engine) {SalesEngine.from_csv({:items => './data/items.csv',
                                  :merchants => './data/merchants.csv'})}
  let(:sales_analyst) {sales_engine.analyst}

  it 'exists' do
    expect(sales_analyst).to be_a SalesAnalyst
  end

  describe '#average_items_per_merchant' do
    it 'gives how many items a merchant has on average' do
      expect(sales_analyst.average_items_per_merchant).to eq 2.88
    end
  end
end