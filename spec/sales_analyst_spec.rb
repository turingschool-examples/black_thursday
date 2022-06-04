require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/sales_analyst"

RSpec.describe SalesAnalyst do
	it 'exists' do
		sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
		sales_analyst = sales_engine.analyst

		expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
	end

	it 'can return the average items per merchant' do
		#total items divided by total merchants
		sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.average_items_per_merchant).to eq(2.88)

	end

	it 'can return the standard deviation of average items per merchant' do
		sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
	end

end
