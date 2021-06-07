require 'SimpleCov'
SimpleCov.start

require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

RSpec.describe SalesEngine do
  before(:each) do
    @se = SalesEngine.from_csv({
                                  :items => './spec/fixture_files/item_fixture.csv',
                                  :merchants => './spec/fixture_files/merchant_fixture.csv',
                                  :invoices => './spec/fixture_files/invoice_fixture.csv',
                                  :invoice_items => './spec/fixture_files/invoice_item_fixture.csv',
                                  :customers => './spec/fixture_files/customer_fixture.csv',
                                  :transactions => './spec/fixture_files/transactions_fixture.csv'
                               })

    @sales_analyst = @se.analyst
  end

  it 'exists' do
    expect(@sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it 'can return average items per merchant' do
    expect(@sales_analyst.average_items_per_merchant).to eq(1.67)
  end

  it 'can return a hash of the merchant ids and items' do
    expected = {
                  5 => @se.items.find_all_by_merchant_id(5),
                  6 => @se.items.find_all_by_merchant_id(6),
                  7 => @se.items.find_all_by_merchant_id(7)
               }

    expect(@sales_analyst.merch_items_hash).to eq(expected)
  end

  it 'can return items by merchant count' do
    expect(@sales_analyst.items_by_merch_count).to eq([1, 1, 3])
  end

  it 'can return average items per merchant standard deviation' do
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(1.15)
  end

  it 'can return merchants with high item count' do
    expect(@sales_analyst.merchants_with_high_item_count.length).to eq(1)
    expect(@sales_analyst.merchants_with_high_item_count).to eq([@se.merchants.find_by_id(7)])
  end

  it 'can return the item prices for a specific merchant' do
    expect(@sales_analyst.price_of_items_for_merch(7)).to eq([12.0, 20.0, 10_000.0])
  end

  it 'can return the average item price for a specific merchant' do
    expect(@sales_analyst.average_item_price_for_merchant(7)).to eq(3_344)
  end

  it 'can return the average price per merchant' do
    expect(@sales_analyst.average_average_price_per_merchant).to eq(1_122)
  end

  it 'can return a set of item prices' do
    expect(@sales_analyst.item_price_set).to eq([10, 12, 12, 20, 10_000])
  end

  it 'can average prices of items' do
    expect(@sales_analyst.average_price_per_item).to eq(2_010.80)
  end

  it 'can average prices of items by standard deviation' do
    expect(@sales_analyst.average_price_per_item_standard_deviation).to eq(4_466.10)
  end

  it 'can return golden items' do
    expect(@sales_analyst.golden_items).to eq([])
  end

  it 'can return average invoices per merchant' do
    expect(@sales_analyst.average_invoices_per_merchant).to eq(1.67)
  end

  it 'can return average invoices per merchant standard deviation' do
    expect(@sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(0.58)
  end

  it 'can return merchants with high invoice count' do
    expect(@sales_analyst.top_merchants_by_invoice_count).to eq([])
  end

  it 'can return merchants with low invoice count' do
    expect(@sales_analyst.bottom_merchants_by_invoice_count).to eq(@se.merchants.all)
  end

  it 'returns date stamps for inovices' do
    expect(@sales_analyst.pull_day_from_invoice).to eq([6, 0, 5, 3, 3])
  end

  it 'returns invoice counts for each day of week' do
    expect(@sales_analyst.days_invoices_hash.values).to eq([1, 0, 0, 2, 0, 1, 1])
  end

  it 'can return average invoices by days of the week' do
    expect(@sales_analyst.average_invoices_per_day).to eq(0.71)
  end

  it 'can return standard deviation for days of the week' do
    expect(@sales_analyst.avg_inv_per_day_std_dev).to eq(0.76)
  end

  it 'can return the top days for invoices' do
   expect(@sales_analyst.top_days_by_invoice_count.length).to eq 1
   expect(@sales_analyst.top_days_by_invoice_count.first.class).to eq String
   expect(@sales_analyst.top_days_by_invoice_count).to eq(['Wednesday'])
 end

  it 'can return the percentage of invoice shipped vs pending vs returned' do
    expect(@sales_analyst.invoice_status(:pending)).to eq(60.0)
    expect(@sales_analyst.invoice_status(:shipped)).to eq(40.0)
    expect(@sales_analyst.invoice_status(:returned)).to eq(0)
  end
########### Iteration 4
  it 'can return a list of invoices with successful payments' do
    expect(@sales_analyst.invoice_id_with_successful_payments).to eq([1, 2, 3, 4, 5])
  end

  it 'can return revenue by invoice id' do
    expected = {
                  1 => 10000.0,
                  2 => 240.0,
                  3 => 3032.0,
                  4 => 10888.0,
                  5 => 810.0
                }
    expect(@sales_analyst.revenue_by_invoice_hash).to eq(expected)
  end
  it 'can find out the total revenue for a given date' do
    expect(@sales_analyst.total_revenue_by_date(Time.parse('2021-05-28'))).to eq(3032.00)
  end

  it 'find the top x performing merchants in terms of revenue' do
    expect(@sales_analyst.top_revenue_earners(2)).to eq([@se.merchants.all[0], @se.merchants.all[2]])
  end

  it 'takes the top 20 merchants by default if no number is given for top_revenue_earners' do
    expect(@sales_analyst.top_revenue_earners).to eq([@se.merchants.all[0], @se.merchants.all[1], @se.merchants.all[2]])
  end

  it 'can return which merchants have pending invoices' do
    expect(@sales_analyst.merchants_with_pending_invoices).to eq([])
    # Note: an invoice is considered pending if none of its transactions are successful.
  end

  it 'can return which merchants offer only one item' do
    expect(@sales_analyst.merchants_with_only_one_item.length).to eq(2)
  end

  xit 'can return merchants that only sell one item by the month they registered (merchant.created_at)' do
    expect(@sales_analyst.merchants_with_only_one_item_registered_in_month("June")).to eq([])
  end

  xit 'can find the total revenue for a single merchant' do
    expect(@sales_analyst.revenue_by_merchant(merchant_id)).to eq(1)
  end
end
