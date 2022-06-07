require 'simplecov'
SimpleCov.start
require './lib/helper'
require 'pry'

RSpec.describe SalesAnalyst do
  let!(:sales_engine) {SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => './data/invoice_items.csv',
    :transactions => './data/transactions.csv',
    :customers => './data/customers.csv'
  })}
  let!(:sales_analyst) {sales_engine.analyst
  }

  it "exists" do
    expect(sales_analyst).to be_instance_of(SalesAnalyst)
  end

  it "can determine average items" do
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it "can determine standard deviation" do
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  #takes a while to test but passes as an array
  xit "can determine which merchant sold the most items?" do
    expect(sales_analyst.merchants_with_high_item_count).to be_instance_of(Array)
  end

  it "can give us avg price of given merchants items" do
    expect(sales_analyst.average_item_price_for_merchant(12334159)).to eq(3150)
  end

  it "can return sum of given merchants item prices" do
    expect(sales_analyst.price_sum_helper(12334159)).to eq(31500)
  end

  it "can sum all of the averages and find the average price across all merchants" do
    expect(sales_analyst.average_average_price_per_merchant).to eq(35029.47)
  end

  it 'returns overall average item price' do
    expect(sales_analyst.average_item_price).to eq(25105.51)
  end

  xit 'returns standard deviation of item price' do
    expect(sales_analyst.item_price_standard_deviation).to eq(290099)
  end

  it 'returns items that are two standard deviations above average item price' do
    expect(sales_analyst.golden_items).to be_instance_of(Array)
    expect(sales_analyst.golden_items.length).to eq(5)
    expect(sales_analyst.golden_items.first.class).to eq(Item)

  end

  it 'returns average invoices per merchant' do
    expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
  end

  it 'returns number of invoices for given merchant' do
     expect(sales_analyst.number_of_invoices_by_merchant_id(12335938)).to eq(16)
   end

  it 'returns average invoices per mechant standard deviation' do
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
  end

  xit 'returns top merchants by invoice count' do
    #array of merchants more than two standard deviations ABOVE the mean
    expect(sales_analyst.top_merchants_by_invoice_count).to be_instance_of(Array)
    # => [merchant, merchant, merchant], include test for values once generating array
  end

  xit 'returns bottom merchants by invoice count' do
    #array of merchants more than two standard deviations BELOW the mean
    expect(sales_analyst.bottom_merchants_by_invoice_count).to be_instance_of(Array)
    # => [merchant, merchant, merchant], include test for values once generating array
  end

  xit 'returns date created for given invoice' do
    expect(sales_analyst.invoice_repository.find_by_id(1).created_at).to eq("2009-02-07")
  end

  xit 'returns day of week a given invoice is created' do
    expect(sales_analyst.invoice_day_of_week_by_id(1)).to eq(6)
    expect(sales_analyst.invoice_day_of_week_by_id(2)).to eq(5)
    expect(sales_analyst.invoice_day_of_week_by_id(4985)).to eq(1)
  end

  xit 'returns total number of items sold by day of week' do
    expect(sales_analyst.invoices_by_day_of_week("Monday")).to eq(696)
    expect(sales_analyst.invoices_by_day_of_week("Tuesday")).to eq(692)
    expect(sales_analyst.invoices_by_day_of_week("Wednesday")).to eq(741)
    expect(sales_analyst.invoices_by_day_of_week("Thursday")).to eq(718)
    expect(sales_analyst.invoices_by_day_of_week("Friday")).to eq(701)
    expect(sales_analyst.invoices_by_day_of_week("Saturday")).to eq(729)
    expect(sales_analyst.invoices_by_day_of_week("Sunday")).to eq(708)
  end

  xit 'returns average invoices by day of week' do
    expect(sales_analyst.average_invoices_by_day_of_week).to eq(712.14)
  end

  xit 'returns standard deviation of average invoices per week' do
    expect(sales_analyst.average_invoices_by_day_of_week_standard_deviation).to eq(18.07)
  end

  xit 'returns days of the week where invoices are created at more than one standard deviation above the mean' do
    expect(sales_analyst.top_days_by_invoice_count.length).to eq(1)
    expect(sales_analyst.top_days_by_invoice_count.first).to eq("Wednesday")
  end

  xit 'returns percent of invoices pending' do
    expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
  end

  xit 'returns percent of invoices shipped' do
    expect(sales_analyst.invoice_status(:shipped)).to eq(56.95)
  end

  xit 'returns percent of invoices returned' do
    expect(sales_analyst.invoice_status(:returned)).to eq(13.5)
  end

  it 'returns whether invoice has been paid in full' do
    expect(sales_analyst.invoice_paid_in_full?(1)).to be true

    expect(sales_analyst.invoice_paid_in_full?(200)).to be true

    expect(sales_analyst.invoice_paid_in_full?(203)).to be false

    expect(sales_analyst.invoice_paid_in_full?(204)).to be false
  end

  it 'returns total $ amount for given invoice' do
    expect(sales_analyst.invoice_total(1)).to eq(21067.77)
  end

  it 'returns array of transactions for a given date' do
    expect(sales_analyst.invoices_by_date("2016-01-06")).to be_instance_of(Array)

    expect(sales_analyst.invoices_by_date("2016-01-06").length).to eq(3)
  end

  it 'returns total revenue for a given date' do
    expect(sales_analyst.total_revenue_by_date("2009-02-07")).to eq(21067.77)
  end

  it 'returns total revenue for a given merchant' do
    expect(sales_analyst.total_revenue_by_merchant(12336175)).to eq(0)

    expect(sales_analyst.total_revenue_by_merchant(12334634)).to eq(192528.87)
  end

  it 'returns sorted array of merchants by revenue' do
    expected = sales_analyst.top_revenue_earners(10)
    first = expected.first
    last = expected.last
    # binding.pry
    expect(expected.length).to eq(10)

    expect(first.class).to eq(Merchant)
    expect(first.id).to eq(12334634)

    expect(last.class).to eq(Merchant)
    expect(last.id).to eq(12335747)
  end

end
