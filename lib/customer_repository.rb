require_relative 'customer'
require 'csv'

class CustomerRepository

  attr_reader :file_path,
              :contents,
              :parent

  def initialize(file_path, parent)
    @file_path = file_path
    @parent    = parent
    @contents  = load_library
  end

  def load_library
    library = {}
    CSV.foreach(file_path, headers: true,
                header_converters: :symbol) do |row|
    h = Hash[row]
    d = h[:id]
    library[d.to_i] = Customer.new(h, self)
    end
    @contents = library
  end

  def all
    contents.map { |k,v| v }
  end

  def find_by_id(cust_id)
    contents[cust_id]
  end

  def find_all_by_first_name(name)
    contents.values.find_all do |v|
      v.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    contents.values.find_all do |v|
      v.last_name.downcase.include?(name.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@contents.size} rows>"
  end

end
