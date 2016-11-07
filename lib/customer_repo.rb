require_relative './customer'
require_relative './data_parser'

class CustomerRepo
  include DataParser
  attr_reader :all

  def initialize(file, parent = nil)
    @all    = parse_data(file).map { |row| Customer.new(row, self) }
    @parent = parent
  end

  def find_by_id(id)
    @all.find { |customer| customer.id.eql?(id) }
  end

  def find_all_by_first_name(first_name)
    @all.find_all { |customer| customer.first_name.downcase.include?(first_name.downcase) }
  end

  def find_all_by_last_name(last_name)
    @all.find_all { |customer| customer.last_name.downcase.include?(last_name.downcase) }
  end
end
