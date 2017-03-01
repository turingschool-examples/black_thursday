require_relative 'merchant'
require_relative 'sales_engine'
require_relative 'item_repository'
require_relative 'item'
require_relative 'merchant_repository'
require_relative 'invoice_item'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer'

class CustomerRepository
  attr_reader :all,
              :parent
  def initialize(customer_data, parent)
    @all = customer_data.map { |raw_data| Customer.new(raw_data)}
    @parent = parent
  end

  def find_by_id(id)
    all.find do |customer|
      id == customer.id
    end
  end

  def find_all_by_first_name(fragment)
    all.find_all do |customer|
      customer.first_name.downcase.include?(fragment.downcase)
    end
  end
  
  def find_all_by_last_name(fragment)
    all.find_all do |customer|
      customer.last_name.downcase.include?(fragment.downcase)
    end
  end
end