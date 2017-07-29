require_relative 'invoice_item'
require 'pry'

class CustomerRepository

  attr_reader :customers,
              :se

  def initialize(customers_path, se)
    @se = se
    @customers = []
    contents = CSV.open customers_path,
                        headers: true,
                        header_converters: :symbol
    contents.each do |row|
      id = (row[:id]).to_i
      first_name = row[:first_name]
      last_name = row[:last_name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      customer = Customer.new(id, first_name, last_name,
                            created_at, updated_at, self)
      @customers << customer
    end
  end

  def all
    @customers
  end

  def find_by_id(customer_id)
    @customers.find do |customer_obj|
      customer_obj.id == customer_id
    end
  end
end
