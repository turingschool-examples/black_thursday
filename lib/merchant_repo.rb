require 'csv'
require_relative 'merchant'
require 'pry'

class MerchantRepo
  attr_reader :merchants, :parent

  def initialize(file,se=nil)
    open_file(file)
    @parent = se
  end

  def open_file(file)
    csv = CSV.foreach file,
    headers: true, header_converters: :symbol
    @merchants = csv.map do |row|
      Merchant.new(row, self)
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

  def merchant_items(id)
    parent.merchant_items(id)
  end

end
