require './lib/csv_parser'
require './lib/merchant'

class MerchantRepository
include CsvParser
attr_reader :sales_engine
attr_accessor :merchants

  def initialize(file_name, sales_engine)
    @merchants = []
    merchant_contents = parse_data(file_name)
    merchant_contents.each do |row|
      @merchants << Merchant.new({id: row[:id].to_i, name: row[:name]}, self)
    end
    # populate_merchants_with_items
    @sales_engine = sales_engine
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find {|merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    @merchants.select do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  # def populate_merchants_with_items
  #   @merchants.each {|merchant| merchant.gather_items}
  # end


end
