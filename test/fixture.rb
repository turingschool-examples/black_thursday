require './lib/sales_engine'

module Fixture
  class << self

    def sales_engine(load_full_data: false)
      SalesEngine.from_csv(filenames load_full_data)
    end

    def data
      SalesEngine.parse_csv(filenames)
    end

    def repo(type)
      repo = sales_engine.repo(type)
      raise "No repo: #{type.inspect}" unless repo
      repo
    end

    def find_record(type, id)
      repo(type).find_by_id(id)
    end

    def new_record(type, data)
      repo(type).insert(data)
    end

    def filenames(load_full_data)
      types = %i{merchants items invoices invoice_items customers transactions}
      paths = types.map do |type|
        if load_full_data
          full_data_path(type)
        else
          fixture_path(type)
        end
      end
      Hash[types.zip(paths)]
    end

    def fixture_path(type)
      "./test/fixture/#{type}.csv"
    end

    def full_data_path(type)
      "./data/#{type}.csv"
    end
  end
end
