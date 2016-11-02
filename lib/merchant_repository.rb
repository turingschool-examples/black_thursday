require_relative 'merchant'
require 'csv'
require 'pry'

class MerchantRepository

  attr_reader   :contents,
                :merchants,
                :parent

  def initialize(path, parent=nil)
    @contents = CSV.open path, headers: true, header_converters: :symbol
    @merchants = contents.map do |line|
      Merchant.new(line)
    end
    @parent = parent
  end

  def all
    @merchants
  end

  def id(id_number)
    merchants.find do |merchant|
      merchant.id == id_number
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
      end
  end

  def find_all_by_name(partial_search)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(partial_search.downcase)
    end
  end

end
