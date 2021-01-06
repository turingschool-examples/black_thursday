require 'csv'

class SalesEngine
  attr_reader :items,
              :merchants

  @@all_items = []
  @@all_merchants = []

  def initialize(items, merchants)
    @items = items
    @merchants = MerchantRepo.new(@@all_merchants)
  end

  def self.from_csv(hash)
    load_items(hash)
    load_merchants(hash)
    SalesEngine.new(@@all_items, @@all_merchants)
  end

  def self.load_items(hash)
    items = CSV.foreach "#{hash[:items]}", headers: true,
    header_converters: :symbol
    items.map do |row|
      @@all_items.push(row)
    end
  end

  def self.load_merchants(hash)
    merchants = CSV.foreach "#{hash[:merchants]}", headers: true,
    header_converters: :symbol
    merchants.map do |row|
      @@all_merchants.push(row)
    end
  end
end
