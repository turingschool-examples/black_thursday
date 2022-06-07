require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/invoice_repository"
require "./lib/sales_analyst"

RSpec.describe SalesAnalyst do
	it 'exists' do
		sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
    })
		sales_analyst = sales_engine.analyst

		expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
	end

	it 'can return the average items per merchant' do
		#total items divided by total merchants
		sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
    })
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.average_items_per_merchant).to eq(2.88)
	end

	it 'can return the standard deviation of average items per merchant' do
		sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
    })
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
	end

	it 'can display the merchants who have the most items for sale' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.merchants_with_high_item_count).to be_a(Array)
		# 52 was the length of our merchants_with_high_sales array
		expect(sales_analyst.merchants_with_high_item_count.count).to eq(52)
	end

	it 'can return average price of a merchants items' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.average_item_price_for_merchant(12334159)).to be_a(BigDecimal)
		expect(sales_analyst.average_item_price_for_merchant(12334159)).to eq(3150.0)
	end

	it 'can return average of the average price per merchant' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.average_average_price_per_merchant).to be_a(BigDecimal)
		expect(sales_analyst.average_average_price_per_merchant).to eq(0.251e5) #(25108.91441111924)
	end

	it "can return a standard deviation" do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst
		expect(sales_analyst.standard_deviation([1, 2 ,3], 2)).to eq(1)
	end

	it 'can return the golden items' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.golden_items).to be_a(Array)
	end

	it 'can average invoices per merchant' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
	end

	it 'can return standard deviation of average invoices per merchant' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
	end

	it 'can calculate zscore for a merchant' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.merchant_z_score(4)).to eq(-1.97)
	end

	it 'can create a hash of merchants by zscore' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.merchants_by_zscore.keys.include?("12334753")).to eq(true)
		expect(sales_analyst.merchants_by_zscore.values.include?(1.37)).to eq(true)
		expect(sales_analyst.merchants_by_zscore["12334753"]).to eq(1.37)
	end

	it 'can return the top performing merchants by invoice count' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
	end

	it 'can return the bottom performing merchants by invoice count' do
	sales_engine = SalesEngine.from_csv({
		:items => "./data/items.csv",
		:merchants => "./data/merchants.csv",
		:invoices => "./data/invoices.csv"
	})
	sales_analyst = sales_engine.analyst

	expect(sales_analyst.bottom_merchants_by_invoice_count.length).to eq(463)
end

	it 'can return the days of the week that see the most sales' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.top_days_by_invoice_count).to eq(["Wednesday"])
	end

	it 'can return the day of the week' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst
		expect(sales_analyst.date_to_day("2009-02-07")).to eq("Saturday")
	end

	it 'can return the invoices by day of the week' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.invoices_by_day.values.count).to eq(7)
	end

	it 'can return the average invoices per day' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.average_invoices_per_day).to eq(712)
	end

	it 'can return the average invoices per day standard deviation' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

		expect(sales_analyst.average_invoices_per_day_standard_deviation).to eq(18.07)
	end

	it 'can calculate z score for a day of the week' do
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst


		expect(sales_analyst.weekday_by_zscore.keys.include?("Saturday")).to eq(true)
		expect(sales_analyst.weekday_by_zscore.values[0].class).to eq(Float)
	end

<<<<<<< HEAD
  it 'can return the percentage of invoices by satus' do
=======
	it 'can return the percentage of invoices by status' do
>>>>>>> af42e2a0c22e9a8ac8fc8faaa6957846608d9c4d
		sales_engine = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv"
		})
		sales_analyst = sales_engine.analyst

<<<<<<< HEAD
    expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
    expect(sales_analyst.invoice_status(:shipped))
    expect(sales_analyst.invoice_status(:returned)).to eq(13.5)
  end
=======
		expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
		expect(sales_analyst.invoice_status(:shipped)).to eq(56.95)
		expect(sales_analyst.invoice_status(:returned)).to eq(13.5)
	end

>>>>>>> af42e2a0c22e9a8ac8fc8faaa6957846608d9c4d

end
