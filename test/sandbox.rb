
require 'pry'
require 'bigdecimal'
require 'csv'


class SalesEngine
  attr_reader :items, :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def self.from_csv(csv_data_source)
    items = CSV.read(csv_data_source[:items], headers: true, header_converters: :symbol)
    merchants = CSV.read(csv_data_source[:merchants], headers: true, header_converters: :symbol)
    self.new(items, merchants)
  end

end

se = SalesEngine.from_csv({
	  :items     => "./data/items.csv",
	  :merchants => "./data/merchants.csv",
	})

  p se.items
  p se.merchants

  se.merchants.each{|row| p    row[:name]}
