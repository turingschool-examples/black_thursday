require 'csv'

class SalesEngine
  @items = []
  @merchants = []

  class << self
    attr_accessor :items,
                  :merchants
  end

  def self.from_csv(hash)
    load_items(hash)
    load_merchants(hash)
  end

  def self.load_items(hash)
    items = CSV.foreach "#{hash[:items]}", headers: true,
    header_converters: :symbol
    items.map do |row|
      @items.push(row)
    end
  end

  def self.load_merchants(hash)
    merchants = CSV.foreach "#{hash[:merchants]}", headers: true,
    header_converters: :symbol
    merchants.map do |row|
      @merchants.push(row)
    end
  end
end
