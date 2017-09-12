require 'pry'
require './lib/merchant'
require 'csv'

class MerchantRepo
  attr_reader :merchants

  def initialize(file)
    open_file(file)
#    self
  end

  def open_file(file)
    csv = CSV.foreach file,
    headers: true, header_converters: :symbol
    @merchants = csv.map do |row|
      Merchant.new(row)
    end
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name == name }
  end

  def find_all_by_name(name)
    merchants_match = []
    merchants_match << merchants.find_all { |merchant| merchant.name.include?(/#{name}/i) }
    merchants_match
  end

end
