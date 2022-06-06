require 'time'
require 'CSV'
require_relative 'customer'
require_relative '../modules/findable'
require_relative '../modules/changeable'

class CustomerRepository
  include Findable
  include Changeable
  attr_reader :all

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end

  def initialize(file_path)
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
       @all << Customer.new({id: row[:id], first_name: row[:first_name], last_name: row[:last_name], created_at: row[:created_at], updated_at: row[:updated_at]})
    end
  end

  def find_all_by_first_name(name)
    @all.find_all {|first_names| first_names.first_name.downcase == name.downcase}
  end

  def find_all_by_last_name(name)
    @all.find_all {|last_names| last_names.last_name.downcase == name.downcase}
  end


  def create(attributes)
    attributes[:id]= find_max_id + 1
    @all << Customer.new(attributes)
  end

  def update(id, attributes)
    customer = find_by_id(id)
    if customer == nil
      exit
    else
      customer.updated_at = Time.now
      attributes[:first_name] == nil ? customer.last_name = attributes[:last_name] : customer.first_name = attributes[:first_name]
      attributes[:last_name] == nil ? customer.first_name = attributes[:first_name] : customer.last_name = attributes[:last_name]
    end
  end

end

#require 'pry'; binding.pry
