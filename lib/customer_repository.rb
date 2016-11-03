require_relative 'parser'
require_relative 'customer'

class CustomerRepository
  include Parser

  attr_reader :all

  def initialize(file_path, parent)
    @all    = create_customers(file_path)
    @parent = parent
  end

  def create_customers(file_path)
    data_row = parse_customers_csv(file_path)
    data_row.map {|row| Customer.new(row, self)}
  end

  def find_by_id(desired_id)
    all.find {|customer| customer.id.eql?(desired_id)}
  end

  def find_all_by_first_name(desired_name)
    all.find_all {|customer| customer.first_name.downcase.include?(desired_name.downcase)}
  end

  def find_all_by_last_name(desired_name)
    all.find_all {|customer| customer.last_name.downcase.include?(desired_name.downcase)}
  end

  def inspect
    '#{self.class}, #{all.count}'
  end

end