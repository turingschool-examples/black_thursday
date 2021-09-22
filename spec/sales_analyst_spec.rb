require './lib/sales_analyst'
require 'csv'

RSpec.describe SalesAnalyst do

  it 'exists' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it 'average_items_per_merchant' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant).to eq 2.88
  end

  it 'average_items_per_merchant_standard_deviation' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq 3.26
  end

  it 'merchants_with_high_item_count' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.merchants_with_high_item_count.count).to eq 52
  end

  it 'average_item_price_for_merchant given a merchant id' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_item_price_for_merchant("12334105")).to eq 1665.67
  end

  it 'average_average_price_per_merchant' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_average_price_per_merchant).to eq 35029.47
  end

it 'golden_items' do
  sales_engine = SalesEngine.new({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"
    })
  sales_analyst = sales_engine.analyst
    expect(sales_analyst.golden_items.count).to eq 5
  end

  it 'average_invoices_per_merchant' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_invoices_per_merchant).to eq 10.49
  end

  it 'average_invoices_per_merchant_standard_deviation' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq 3.29
  end

  it 'top_merchants_by_invoice_count' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.top_merchants_by_invoice_count.count).to eq 12
  end

  it 'bottom_merchants_by_invoice_count' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.bottom_merchants_by_invoice_count.count).to eq 4
  end

  it 'top_days_by_invoice_count' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.top_days_by_invoice_count).to eq(["Wednesday", "Saturday"])
  end

  it 'invoice_status by percentage' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.invoice_status(:pending)).to eq 29.55
    expect(sales_analyst.invoice_status(:shipped)).to eq 56.95
    expect(sales_analyst.invoice_status(:returned)).to eq 13.5
  end

  it 'invoice_paid_in_full?' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.invoice_paid_in_full?(2179)).to eq true
    # sales_analyst.invoice_paid_in_full?(invoice_id) returns true
    # if the Invoice with the corresponding id is paid in full
  end

  it 'returns the total $ amount of an invoice' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.invoice_total(1)).to eq 2106777
    # sales_analyst.invoice_total(invoice_id) returns the total $
    # amount of the Invoice with the corresponding id.
  end
end
