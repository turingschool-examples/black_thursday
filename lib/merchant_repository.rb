require './lib/csv_parser'
require './lib/merchant'

class MerchantRepository
include CsvParser

attr_accessor :merchants

  def initialize(file_name)
    @merchants = []
    merchant_contents = parse_data(file_name)
    merchant_contents.each do |row|
      @merchants << Merchant.new({id: row[:id].to_i, name: row[:name]})
    end
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


end
