
require './lib/sales_engine'
require './lib/fixturable'

SalesAnalyst.include(Fixturable)
se = SalesEngine.from_csv(
  {
    items: './data/items.csv',
    merchants: './data/merchants.csv',
    invoices: './data/invoices.csv',
    invoice_items: './data/invoice_items.csv',
    transactions: './data/transactions.csv',
    customers: './data/customers.csv'
  }
)
@sa = se.analyst
@sa.create_sample
