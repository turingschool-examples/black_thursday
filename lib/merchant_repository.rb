require_relative 'find_functions'
require './lib/merchant'
require 'csv'


class MerchantRepository
  include FindFunctions

  attr_reader :file_contents, 
              :merchant_objects

  def initialize(file_name = nil)
    return unless file_name
    @file_contents = load(file_name)
    @merchant_objects = create_merchant_objects
  end

  def load(file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end

  def create_merchant_objects
    @file_contents.map {|row| Merchant.new(row)}
  end

  def all
    @merchant_objects
  end

  def find_by_id(id)
    find_by(@merchant_objects, :id, id)
    #dropped the module name and took out `self.` in the methods.
    #added method as middle argument to use in `#send(method)`
  end

  def find_by_name(name)
    find_by(@merchant_objects, :name, name)
  end

  def find_all_by_name(name)
    find_all(@merchant_objects, :name, name)
  end

end
