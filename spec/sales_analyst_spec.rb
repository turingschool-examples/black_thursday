require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'

RSpec.describe do

  describe 'initialize' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./data/items.csv",
                                        :merchants => "./data/merchants.csv",
                                        })
    sales_analyst = sales_engine.analyst

    it 'exists' do
      expect(sales_analyst.engine).to be_an_instance_of(SalesEngine)
    end
  end
end
