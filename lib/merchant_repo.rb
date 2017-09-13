require 'csv'
require_relative 'merchant'
require 'pry'

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
    merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    merchants.find_all { |merchant| merchant.name.downcase.include?(name.downcase) }
  end

end
