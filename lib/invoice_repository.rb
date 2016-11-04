require_relative 'find_functions'
require_relative 'invoice'
require 'csv'
require 'pry'

class InvoiceRepository

  include FindFunctions

  attr_reader :file_contents,
              :all,
              :parent

  def initialize(file_name = nil, engine = nil)
    return unless file_name
    @parent        = engine
    @file_contents = load(file_name)
    @all           = create_item_objects
  end

  def inspect
    "#<#{self.class}: #{@all.count} rows>"
  end

  def load(file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end

  def create_item_objects
    @file_contents.map {|row| Invoice.new(row, self)}
  end

  def find_merchant_by_id(id)
    parent.find_merchant_by_id(id)
  end

  def find_by_id(id)
    find_by(:id, id)
  end

  def find_all_by_customer_id(customer_id)
    # binding.pry
    find_all(:customer_id, customer_id)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all(:merchant_id, merchant_id)
  end

  def find_all_by_status(status)
    find_all(:status, status.to_s)
  end

end
