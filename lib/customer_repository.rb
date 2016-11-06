require_relative 'find_functions'
require_relative 'customer'
require 'csv'

class CustomerRepository

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
    @file_contents.map { |row| Customer.new(row, self) }
  end

  def find_by_id(id)
    find_by(:id, id)
  end

  def find_all_by_first_name(first_name)
    find_all(:first_name, first_name)
  end

  def find_all_by_last_name(last_name)
    find_all(:last_name, last_name)
  end

end
