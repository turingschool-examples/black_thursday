require_relative 'sales_engine'

module TestSetup

  @@se = SalesEngine.from_csv({
    :invoices => "./data/invoices.csv",
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :transactions => "./data/transactions.csv"
    })

end
