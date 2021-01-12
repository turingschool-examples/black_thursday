require 'csv'
require 'bigdecimal'
require 'time'
require_relative './customer'

class CustomerRepository
  attr_reader :all,
              :engine

  def initialize(items_path, engine)
    @all = []
    @engine = engine

    CSV.foreach(items_path, headers: true, header_converters: :symbol) do |row|
      @all << convert_to_customer(row)
    end
  end

  def convert_to_customer(row)
    row = Customer.new({id: row[:id].to_i,
                    first_name: row[:first_name],
                    last_name: row[:last_name],
                    created_at: row[:created_at],
                    updated_at: row[:updated_at]
                   }, self)
  end

  def find_by_id(id)
    @all.find do |customer|
      customer.id == id
    end
  end

  def find_all_with_name(first_or_last_name, name)
    first_or_last_name = first_or_last_name.downcase.strip
    @all.find_all do |customer|
      if first_or_last_name == "first name"
        customer.first_name.downcase.include?(name.downcase.strip)
      elsif first_or_last_name == "last name"
        customer.last_name.downcase.include?(name.downcase.strip)
      else
        puts "can't sort by that attribute"
        break
      end
    end
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @all << Customer.new(attributes, self)
  end

  def new_highest_id
    all.max_by do |instance|
      instance.id
    end.id + 1
  end

  def update(id, attributes)
    if attributes.keys.include?(:first_name && :last_name) && !find_by_id(id).nil?
      customer = find_by_id(id)
      customer.first_name = attributes[:first_name]
      customer.last_name = attributes[:last_name]
      customer.updated_at = Time.now.strftime("%d/%m/%Y")
    end
  end

  def delete(id)
    remove = find_by_id(id)
    @all.delete(remove)
  end
end
