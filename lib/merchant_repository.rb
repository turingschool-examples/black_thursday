require_relative 'find_functions'
require_relative 'merchant'
require 'csv'

class MerchantRepository

  include FindFunctions

  attr_reader :file_contents,
              :all,
              :parent

  def initialize(file_name = nil, sales_engine = nil)
    return unless file_name
    @parent        = sales_engine
    @file_contents = load(file_name)
    @all           = create_merchant_objects
  end

  def inspect
    "#<#{self.class}: #{@all.count} rows>"
  end

  def load(file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end

  def create_merchant_objects
    file_contents.map { |row| Merchant.new(row, self) }
  end

  def find_items_by_merchant_id(merchant_id)
    parent.find_items_by_merchant_id(merchant_id)
  end

  def find_invoices(merchant_id)
    parent.find_invoices(merchant_id)
  end

  def find_customers_of_merchant(merchant_id)
    parent.find_customers_of_merchant(merchant_id)
  end

  def find_by_id(id)
    find_by(:id, id)
  end

  def find_by_name(name)
    find_by(:name, name)
  end

  def find_all_by_name(name)
    find_all(:name, name)
  end

end
