require_relative 'merchant_repository'
require_relative 'item_repository'
require "csv"


class SalesEngine

  def self.from_csv(filenames)
    options = { headers: true, header_converters: :symbol }
    tables = filenames.transform_values do |filename|
      CSV.foreach(filename, options).map do |row|
        row.to_hash
      end
    end
    new(tables)
  end

  def initialize(data)
    @repos = {}
    @repos[:items] = ItemRepository.new(self, data[:items]) if data[:items]
    @repos[:merchants] = MerchantRepository.new(self, data[:merchants]) if data[:merchants]
  end

  def repo(type)
    @repos[type]
  end

  def merchants
    repo :merchants
  end

  def items
    repo :items
  end

end
