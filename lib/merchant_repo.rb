require './lib/merchant'
require 'csv'
require 'pry'
class MerchantRepo

  attr_reader :merchants, :parent

  def initialize(file, se=nil)
    @merchants = {}
    open_file(file)
    @parent    = se
  end

  def open_file(file)
    CSV.foreach file,  headers: true, header_converters: :symbol do |row|
      merchants[row[:id].to_i] = Merchant.new(row, self)
    end
  end

  def all
    merchants.values
  end

  def find_by_id(id)
    merchants[id]
  end

  def find_by_name(name)
    all.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def items_of_merchant(id)
    parent.items_of_merchant(id)
  end




end
