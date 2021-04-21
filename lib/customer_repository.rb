require 'CSV'
require_relative 'csv_adapter'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

require_relative 'customer.rb'
require_relative 'crud.rb'
require 'time'

class CustomerRepository
include Crud

  attr_reader :collection

  def initialize(filepath, parent)
    @collection = []
    loader(filepath)
    @parent = parent
  end

  def create(attributes)
    if @collection != []
      largest = (@collection.max_by {|element| element.id})
      attributes[:id] = (largest.id + 1)
    else
      attributes[:id] = 1
    end
    i = Customer.new(attributes, self)
    @collection << i
  end

  def find_all_by_id(number)
    find_all_by_exact("id", number)
  end

  def find_all_by_first_name(name)
    find_all_by("first_name", name)
  end
  
  def find_all_by_last_name(l_name)
    find_all_by("last_name", l_name)
  end

  def all
    @collection
  end

  def loader(filepath)
    customer_table = load(filepath)
     customer_table.map do |customer|
       customer[:id]                          = customer[:id].to_i
       customer[:first_name]                  = customer[:first_name]
       customer[:last_name]                   = customer[:last_name]
       customer[:updated_at]                  = Time.parse(customer[:updated_at])
       customer[:created_at]                  = Time.parse(customer[:created_at])
     @collection << Customer.new(customer, @parent)
     end
   end
  
   def update(id, attributes)
    customer = find_by_id(id)
    empty_first = attributes[:first_name].nil?
    empty_last = attributes[:last_name].nil?
    customer.first_name = attributes[:first_name] unless empty_first
    customer.last_name = attributes[:last_name] unless empty_last
    customer.updated_at = Time.now unless empty_first && empty_last
    customer  
  end

end