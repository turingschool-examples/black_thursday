require './lib/sales_analyst'
require './lib/sales_engine'
require 'rspec'

RSpec.describe SalesAnalyst do
  context 'Instanstiation' do
    it 'exists' do
      sales_analyst = SalesEngine.analyst

      expect(sales_analyst).to be_instance_of(SalesAnalyst)
    end
  end

  context '#average_items_per_merchant' do
    it 'can return average items per merchant' do
      se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })

      sales_analyst = SalesEngine.analyst
      mr = se.merchants
      ir = se.items

      expect(sales_analyst.average_items_per_merchant).to eq(2.88) 
    end
  end
end
