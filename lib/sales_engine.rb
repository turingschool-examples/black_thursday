require "csv"
require "merchant"
require "item"
require "invoice"
require "sales_analyst"
require "pry"

class SalesEngine
  attr_reader :merchants_instances_array, :items_instances_array, :invoices_instances_array, :analyst

  def initialize(data)
    @items_data = data[:items]
    @merchants_data = data[:merchants]
    @invoices_data = data[:invoices]
    @merchants_instances_array = []
    @items_instances_array = []
    @invoices_instances_array = []
  end

  def self.from_csv(argument)
    items = CSV.read(argument[:items], headers: true, header_converters: :symbol)
    merchants = CSV.read(argument[:merchants], headers: true, header_converters: :symbol)
    invoices = CSV.read(argument[:invoices], headers: true, header_converters: :symbol)
    SalesEngine.new({items: items, merchants: merchants, invoices: invoices})
  end

  def analyst
    SalesAnalyst.new(items_instanciator, merchants_instanciator, invoices_instanciator)
  end

  def items
    @items_data
  end

  def merchants
    @merchants_data
  end

  def invoices
    @invoices_data
  end

  def items_instanciator
    items_instances_array = []
    items.by_row!.each do |row|
      items_instances_array << Item.new(row)
    end
    items_instances_array
  end

  def merchants_instanciator
    merchants.by_row!.each do |row|
      merchants_instances_array << Merchant.new(row)
    end
    merchants_instances_array
  end

  def invoices_instanciator
    invoices.by_row!.each do |row|
      invoices_instances_array << Invoice.new(row)
    end
    invoices_instances_array
  end

end
