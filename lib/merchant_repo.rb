require_relative 'merchant'
require 'csv'
class MerchantRepo

  attr_reader :all_merchants, :parent

  def initialize(file, se=nil)
    @all_merchants = []
    open_file(file)
    @parent    = se
  end

  def open_file(file)
    CSV.foreach file,  headers: true, header_converters: :symbol do |row|
      all_merchants <<  Merchant.new(row, self)
    end
  end

  def find_by_id(merch_id)
    all_merchants.find {|merchant| merchant.id == merch_id }
  end

  def find_by_name(name)
    all_merchants.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(name)
    all_merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def items_of_merchant(id)
    parent.items_of_merchant(id)
  end
end
