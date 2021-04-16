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
end
