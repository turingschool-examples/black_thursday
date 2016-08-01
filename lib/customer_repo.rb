require "csv"
require_relative "../lib/customer"

class CustomerRepo

  def initialize(csv_filepath, parent = nil)
    contents = CSV.open csv_filepath, headers: true, header_converters: :symbol
    @customer_objects = contents.map do |row|
      Customer.new(row, self)
    end
    @parent = parent
    # @customer_objects = []
  end

  # def from_csv(filepath)
  #   contents = CSV.open filepath, headers: true, header_converters: :symbol
  #     @customer_objects = contents.map do |row|
  #     Customer.new(row, self)
  #   end
  # end

  def all
    @customer_objects
  end

  def find_by_id(customer_id)
    @customer_objects.detect do |customer|
      customer.id == customer_id
    end
  end

  def find_all_by_first_name(customer_first_name)
    @customer_objects.select do |customer|
      customer.first_name.upcase.include?(customer_first_name.upcase)
    end
  end

  def find_all_by_last_name(customer_last_name)
    @customer_objects.select do |customer|
      customer.last_name.upcase.include?(customer_last_name.upcase)
    end
  end

  def find_all_merchants_by_customer_id(customer_id)
    @parent.find_all_merchants_by_customer_id(customer_id)
  end

end
