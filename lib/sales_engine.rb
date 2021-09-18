require 'csv'
require './lib/merchantrepository'
require './lib/merchant'

class SalesEngine

  attr_reader :items, :merchants

  def initialize(data)
    @items = data[:items]
    @merchants = data[:merchants]
  end

  def self.from_csv(info)
    SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv"})
  end

  def merchants
    all = []

    csv = CSV.table(@merchants, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << Merchant.new(row)
    end
   MerchantRepository.new(all)
  end

  def items
    all = []

    csv = CSV.read(@items, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << Item.new(row)
    end
    ItemRepository.new(all)
  end
end
