require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require 'CSV'
require 'simplecov'
SimpleCov.start

RSpec.describe SalesAnalyst do

  describe 'creates a sales analyst' do

    it 'exists' do
      sales_engine = SalesEngine.from_csv({
            :items     => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            })
      sales_analyst = sales_engine.analyst
      expect(sales_analyst).to be_a(SalesAnalyst)
    end

  end

end
