require "csv"
require "merchant"
require "item"
require "pry"

class SalesEngine
  def initialize(data)
    @items_data = data[:items]
    @merchants_data = data[:merchants]
  end

  def self.from_csv(argument)
    items = CSV.read(argument[:items], headers: true, header_converters: :symbol)
    merchants = CSV.read(argument[:merchants], headers: true, header_converters: :symbol)
    SalesEngine.new({items: items, merchants: merchants})
  end

  def items
    @items_data
  end

  def merchants
    @merchants_data
  end

  def items_instanciator
    items_instances_array = []
    items.by_row!.each do |row|
      items_instances_array << Item.new(row)
    end
    items_instances_array
  end

  def merchants_instanciator
    merchants_instances_array = []
    merchants.by_row!.each do |row|
      merchants_instances_array << Merchant.new(row)
    end
    merchants_instances_array
  end
end
