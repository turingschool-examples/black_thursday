require 'csv'
require './lib/sales_engine'
require './lib/customer'

class CustomerRepository
  attr_reader :all
  def initialize(customer_path)
    @all = (
      customer_objects = []
      CSV.foreach(customer_path, headers: true, header_converters: :symbol) do |row|
        customer_objects << Customer.new(row)
      end
      customer_objects)
  end

  def find_by_id(id)
    if (@all.any? do |customer|
      customer.id == id
    end) == true
      @all.find do |customer|
        customer.id == id
      end
    else
      nil
    end
  end

  # def find_all_by_first_name
  #
  # end
  #
  # def find_all_by_last_name
  #
  # end

  def create(attributes)
    new_customer = Customer.new(attributes)
    @all << new_customer
  end

  # def update(id, new_first_name, new_last_name)
  #   if find_by_id(id) != nil
  #     (find_by_id(id).first_name.clear.gsub!("", new_first_name))
  #     (find_by_id(id).last_name.clear.gsub!("", new_last_name))
  #   end
  # end
  #
  # def delete(id)
  #   if find_by_id(id) != nil
  #     @all.delete(@all.find do |merchant|
  #       merchant.id == id
  #     end)
  #   end
end
