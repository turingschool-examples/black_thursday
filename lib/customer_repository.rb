require_relative 'searching'

class CustomerRepository
  include Searching
  attr_reader :all

  def initialize(file_path, sales_eng)
    @all       = from_csv(file_path)
    @sales_eng = sales_eng
  end

  def add_elements(data)
    data.map { |row| Customer.new(row, self) }
  end

  def find_by_first_name(name)
    @all.find_all do |cust|
      cust.first_name.upcase.include?(name.upcase)
    end
  end

  def find_by_last_name(name)
    @all.find_all do |cust|
      cust.last_name.upcase.include?(name.upcase)
    end
  end

  def merchants(id)
    @sales_eng.merchants.find_all_by_id(id)
  end

  def inspect
    "#<#{self.class} #{@all.length} rows>"
  end
end
