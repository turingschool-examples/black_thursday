require './lib/sales_engine'

module Fixture
  class << self

    def sales_engine
      SalesEngine.from_csv(filenames)
    end

    def data
      SalesEngine.parse_csv(filenames)
    end

    def repo(type)
      sales_engine.repo(type)
    end

    def find_record(type, id)
      repo(type).find_by_id(id)
    end

    def new_record(type, data)
      repo(type).insert(data)
    end

    def filenames
      {
        merchants: './test/fixture/merchants.csv',
        items: './test/fixture/items.csv',
        invoices: './test/fixture/invoices.csv',
        customers: './test/fixture/customers.csv',
        invoice_items: './test/fixture/invoice_items.csv',
        transactions: './test/fixture/transactions.csv'
      }
    end

  end
end
