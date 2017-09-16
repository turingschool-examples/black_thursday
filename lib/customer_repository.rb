require_relative 'customer'
require 'csv'

class CustomerRepository
  attr_accessor :all, :parent

  def initialize(file_path, parent=nil)
    @all    = create_customers(file_path)
    @parent = parent
  end

  def csv_parse(file_path)
    CSV.open file_path, headers: true, header_converters: :symbol
  end

  def create_customers(file_path)
    csv_parse(file_path).map {|row| Customer.new(row, self)}
  end

  def find_by_id (id)
    all.find {|customer| customer.id == id}
  end

  def find_all_by_first_name(prefix)
    all.select {|customer| customer.first_name.downcase.include?(prefix.downcase)}
  end

  def find_all_by_last_name(prefix)
    all.select {|customer| customer.last_name.downcase.include?(prefix.downcase)}
  end

  def find_merchants_by_customer(id)
    @parent.find_merchants_by_customer(id)    
  end

  def inspect
    "#{self.class}"
  end
end
