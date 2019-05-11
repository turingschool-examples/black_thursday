require 'sinatra'
require_relative '../lib/sales_engine'

get '/' do
  haml :index
end

get '/dashboard' do
  engine = SalesEngine.from_csv(
    customers: './data/customers.csv',
    invoices: './data/invoices.csv',
    invoice_items: './data/invoice_items.csv',
    items: './data/items.csv',
    merchants: './data/merchants.csv',
    transactions: './data/transactions.csv'
  )
  analyst = engine.analyst
  haml :dashboard, :locals => {
    avg_item_price: analyst.average_item_price,
    golden_items: analyst.golden_items.map(&:name),
    one_time_buyers: analyst.one_time_buyers.map { |customer| "#{customer.first_name} #{customer.last_name}"},
    top_item_bought_once: analyst.one_time_buyers_top_item.name,
    avg_invoices_per_day: analyst.average_invoices_per_day,
    top_days_by_invoice_count: analyst.top_days_by_invoice_count,
    avg_items_per_merchant: analyst.average_items_per_merchant,
    top_merchants: analyst.top_merchants_by_invoice_count.map(&:name),
    bottom_merchants: analyst.bottom_merchants_by_invoice_count.map(&:name) }
end
