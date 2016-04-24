require_relative 'customer'
require 'pry'

class CustomerRepository
  attr_accessor :customer_repository

  def initialize(parent = nil)
    @se = parent
    @customer_repository = []
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def customer(customer_repo)
    customer_repo.each do |column|
      @customer_repository << Customer.new(column, self)
    end
    self
  end

  def all
    customer_repository.empty? ?  nil : @customer_repository
  end

  def find_by_id(find_id)
    customer_repository.find {|customer| customer.id == find_id }
  end

  def find_all_by_first_name(find_name)
    customer_repository.find_all do |customer|
      customer.first_name.downcase.include?(find_name.downcase)
    end
  end

  def find_all_by_last_name(find_name)
    customer_repository.find_all do |customer|
      customer.last_name.downcase.include?(find_name.downcase)
    end
  end

  def find_invoices_by_customer_id(customer_id)
    @se.find_customer_by_invoice_customer_id(customer_id)
  end

  def find_merchants_by_invoice_merchant_id(merchant_id)
    @se.find_merchant_by_merch_id(merchant_id)
  end
end
