require 'csv'
require 'bigdecimal'
require 'time'
require_relative './repository_module'

class CustomerRepository

  include RepoMethods

  def initialize(filepath = nil)
    @filepath = filepath
    @all = []
    split(filepath) if filepath != nil
  end

  def create(attributes)
    is_included = @all.any? do |invoice_item|
      attributes[:id] == invoice_item.id
    end
    is_included = false if @all == []
    has_id = attributes[:id] != nil
    if has_id && !is_included
      @all << Customer.new(attributes)
    elsif @all == []
      new_id = 1
      attributes[:id] = new_id
      @all << Customer.new(attributes)
    else
      highest_id = @all.max_by do |invoice_item|
        invoice_item.id
      end.id
      new_id = highest_id + 1
      attributes[:id] = new_id
      @all << Customer.new(attributes)
    end
  end

  def split(filepath)
    objects = CSV.open(filepath, headers: true, header_converters: :symbol)
    attributes_array = []
    objects.map do |object|
      object[:id] = object[:id].to_i

      object[:first_name] = object[:first_name]

      object[:last_name] = object[:last_name]

      object[:created_at] = Time.parse(object[:created_at])

      object[:updated_at] = Time.parse(object[:updated_at])

      attributes_array << object.to_h
    end
    attributes_array.each do |hash|
      create(hash)
    end
  end

  def find_all_by_first_name(name)
    @all.find_all do |customer|
      customer_name = customer.first_name.downcase
      customer_name.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @all.find_all do |customer|
      customer_name = customer.last_name.downcase
      customer_name.include?(name.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
