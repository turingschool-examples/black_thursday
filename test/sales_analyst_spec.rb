require './lib/sales_analyst'

describe SalesAnalyst do
  it 'exists' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})

    ir = se.items
    mr = se.merchants
    sales_analyst = se.analyst

    expect(ir).to be_a(ItemRepository)
    expect(mr).to be_a(MerchantRepository)
    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  it 'calculates average items per merchant' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    sales_analyst = se.analyst

    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'calculates standard deviation' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    sales_analyst = se.analyst

    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end


  it 'shows merchants that sell a lot of items' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    sales_analyst = se.analyst

    expect(sales_analyst.merchants_with_high_item_count.count).to eq(52)
  end

  it 'shows average price of merchant items' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    sales_analyst = se.analyst

    expect(sales_analyst.average_item_price_for_merchant(12334159)).to eq(0.315e2)
    expect(sales_analyst.average_item_price_for_merchant(12336819)).not_to eq(0.315e2)
  end

  it 'shows the average average price of merchant items' do

    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    sales_analyst = se.analyst

    expect(sales_analyst.average_average_price_per_merchant).to eq(0.350294697495132e3)
  end

  it 'can list golden items' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    sales_analyst = se.analyst

    expect(sales_analyst.golden_items.count).to eq(ir.find_all_by_price_in_range(6155.6711, Float::INFINITY).count)
  end

  it 'can find the average invoices per merchant' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    sales_analyst = se.analyst

    expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
  end

  it 'can find the standard deviation invoices per merchant' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    sales_analyst = se.analyst

    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
  end

  it 'can find the percentage of invoices by status' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst

    expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
  end

  it 'can tell us who are the merchants with a high number of invoices' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst

    expect(sales_analyst.top_merchants_by_invoice_count.count).to eq(4)
  end

  it 'can tell us who are the merchants with a low number of invoices' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst

    expect(sales_analyst.bottom_merchants_by_invoice_count.count).to eq(361)
  end

  it 'can group invoices into a hash by day of week' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst
    expect(sales_analyst.invoices_per_day["Monday"].count).to eq(696)
    expect(sales_analyst.invoices_per_day["Tuesday"].count).to eq(692)
  end

  it 'can tell the average number of invoices on a day of the week' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst

    expect(sales_analyst.invoices_per_day_count["Monday"]).to eq(696)
  end

  it 'can find the average invoices per day' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst

    expect(sales_analyst.average_invoices_per_day).to eq(712.14)
  end

  it 'can find the average invoices per day standard deviation' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst

    expect(sales_analyst.average_invoices_per_day_standard_deviation).to eq(0.63)
  end

  it 'can find the average invoices per day standard deviation' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst

    expect(sales_analyst.top_days_by_invoice_count).to eq(["Wednesday", "Thursday", "Saturday"])
  end
  it 'can see if an invoice is paid in full' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst

    expect(sales_analyst.invoice_paid_in_full?(30)).to eq(false)
    expect(sales_analyst.invoice_paid_in_full?(750)).to eq(true)
  end
  it 'can see if an invoice is paid in full' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst

    expect(sales_analyst.invoice_total(1)).to eq(0.348956e4)
    expect(sales_analyst.invoice_total(2)).to eq(0.9388e3)
  end

  it 'can calculate total revenue by date' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst

    expect(sales_analyst.total_revenue_by_date("2012-03-27")).to eq(0.1093395364e8)
  end

  it 'can return top merchants by revenue' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst
    expect(sales_analyst.top_revenue_earners(5).count).to eq(5)
    expect(sales_analyst.top_revenue_earners.count).to eq(20)
  end

  it 'can return merchants with pending invoices' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst
    expect(sales_analyst.merchants_with_pending_invoices.count).to eq(448)
  end

  it 'can return merchants with only 1 item' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst
    expect(sales_analyst.merchants_with_only_one_item.count).to eq(243)
  end

  it 'can tell which merchants register with only 1 item in a month' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst

    expect(sales_analyst.merchants_with_only_one_item_registered_in_month("January").count).to eq(19)
  end

  it 'can find the revenue by merchant' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = se.analyst

    expect(sales_analyst.revenue_by_merchant(12334634)).to eq(54811.15)
    expect(sales_analyst.revenue_by_merchant(12336175)).to eq(17762.16)
  end


end
