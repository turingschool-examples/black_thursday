require 'csv'
require_relative '../lib/merchant_repo'
require 'bigdecimal'
require 'pry'

class Merchant
  attr_reader :parent,
              :id,
              :name,
              :created_at,
              :updated_at
              
  def initialize(data, repo)
      @parent = repo
      @id = data[:id].to_i
      @name = data[:name].to_s
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def items
    @parent.find_all_by_merchant_id(id)
  end

  def invoices
    @parent.find_all_invoices_by_id(id)
  end

  def num_items
    items.length
  end

  def num_invoices
    invoices.length
  end

  def customers
    customers = find_all_invoices_by_id(id).map do |customer|
      @parent.find_customers(customer.customer_id)
    end
    customers.uniq
  end

  def find_all_invoices_by_id(id)
    @parent.find_all_customers_for_merchant(id)
  end
end