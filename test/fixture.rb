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
      types = %i{merchants items invoices invoice_items customers transactions}
      paths = types.map{ |type| fixture_path(type) }
      Hash[types.zip(paths)]
    end

    def fixture_path(type)
      "./test/fixture/#{type}.csv"
    end

  end
end
