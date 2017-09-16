require_relative 'csv_parser'
require_relative 'customer'

class CustomerRepository
  include CsvParser
  attr_reader :sales_engine
  attr_accessor :customers

  def initialize(file_name, sales_engine)
    @customers = []
    item_contents = parse_data(file_name)
    item_contents.each do |row|
      @customers << Customer.new(row, self)
    end
    @sales_engine = sales_engine
  end

  def all
    customers
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
