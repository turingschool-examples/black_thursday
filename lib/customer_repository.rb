require 'pry'
require 'csv'
require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository

#  def inspect
#    "#<\#{self.class} \#{@customers.size} rows>"
#  end

  attr_reader :customers

  def initialize(data)
    @customers=[]
    CSV.foreach(data, headers: true, header_converters: :symbol) do |row| header ||= row.headers
      @customers << Customer.new(row)
    end
    super(@customers)
  end

  # def all
  #   @customers
  # end
  #
  # def find_by_id(id)
  #   @customers.find {|item| item.id == id}
  # end

  def find_all_by_first_name(first_name)
    @customers.find_all {|item| item.first_name.downcase.include?(first_name.downcase)}
  end

  def find_all_by_last_name(last_name)
    @customers.find_all {|item| item.last_name.downcase.include?(last_name.downcase)}
  end

  def create(attributes)
    attributes[:id] = @customers.last.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new_item = Customer.new(attributes)
    @customers << new_item
    new_item
  end

  def update(id, attributes)
    item_to_update = find_by_id(id)
    if item_to_update != nil
        attributes.each do |key, value|
          if ![:id, :created_at].include?(key)
            item_to_update.last_name = value
            item_to_update.updated_at = (Time.now + 1)
          end
        end
    end
    item_to_update
  end

  # def delete(id)
  #   @customers.delete(find_by_id(id)) if find_by_id(id) != nil
  #   end
end
