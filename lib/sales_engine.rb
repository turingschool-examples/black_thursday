require 'csv'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def self.from_csv(csv_hash)
    items_input = CSV.read(csv_hash[:items], headers: true, header_converters: :symbol)
    merchants_input = CSV.read(csv_hash[:merchants], headers: true, header_converters: :symbol)
    se = SalesEngine.new(items_input, merchants_input)
  end
end
