require_relative 'find_functions'
require_relative '../lib/merchant'
require 'csv'


class MerchantRepository
  include FindFunctions

  attr_reader :file_contents,
              :all

  def initialize(file_name = nil)
    return unless file_name
    @file_contents = load(file_name)
    @all = create_merchant_objects
  end

  def load(file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end

  def create_merchant_objects
    @file_contents.map {|row| Merchant.new(row, self)}
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
