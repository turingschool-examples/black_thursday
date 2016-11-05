require_relative 'customer'
require 'csv'

class CustomerRepository
  attr_reader   :contents,
                :customers,
                :parent

  def initialize(path, parent = nil)
    @contents = CSV.open path, headers: true, header_converters: :symbol
    @parent = parent
    @customers = contents.map do |line|
      Customer.new(line, self)
    end
  end

  def all
    customers
  end

  def find_by_id(id_number)
    all.find do |customer|
      customer.id == id_number
    end
  end

  def find_all_by_first_name(first_name)
    all.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    all.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end