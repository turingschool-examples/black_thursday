require_relative 'merchant_repository'
require_relative 'item_repository'
require "csv"


class SalesEngine

  def self.from_csv(filenames)
    options = {headers: :true, header_converters: :symbol}
    tables = filenames.transform_values do |filename|
      CSV.foreach(filename, options).map do |row|
        row.to_hash
      end
    end
    new(tables)
  end

  attr_reader :items, :merchants
  def initialize(data)
    @items = ItemRepository.new(data[:items]) if data[:items]
    @merchants = MerchantRepository.new(data[:merchants]) if data[:merchants]
  end

end
