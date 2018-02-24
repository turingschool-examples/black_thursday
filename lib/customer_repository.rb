require_relative 'searching'

class CustomerRepository
  include Searching
  attr_reader :all

  def initialize(file_path)
    @all = from_csv(file_path)
  end

  def add_elements(data)
    data.map { |row| Customer.new(row) }
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

  def inspect
    "#<#{self.class} #{@all.length} rows>"
  end
end
