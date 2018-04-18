require 'sinatra'
require_relative '../lib/sales_engine'

get '/' do
  "Black Thursday!"
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
  haml :dashboard, :locals
end
