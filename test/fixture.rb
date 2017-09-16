module Fixture
  class << self

    def sales_engine
      SalesEngine.from_csv({
        merchants: './test/fixture/merchants.csv',
        items: './test/fixture/items.csv',
        invoices: './test/fixture/invoices.csv'
      })
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

  end
end
