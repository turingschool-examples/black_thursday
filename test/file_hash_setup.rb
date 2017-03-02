
module FileHashSetup

  def setup
    @file_hash = { customers: './data/customers.csv',
              transactions: './data/transactions.csv',
              invoices: './data/invoices.csv',
              items: './data/items.csv',
              merchants: './data/merchants.csv',
              invoice_items: './data/invoice_items.csv'
              }

    @se = SalesEngine.from_csv(file_hash)
  end
end
