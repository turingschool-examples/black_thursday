require_relative 'merchant'
require 'pry'

class MerchantRepository
  attr_accessor :merchant_array

  def initialize(parent = nil)
    @se = parent
    @merchant_array = []
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end

  def merchant_repo(merchant_contents)
    merchant_contents.each do |column|
      @merchant_array << Merchant.new(column, self)
    end
    self
  end

  def all
    merchant_array.empty? ?  nil : merchant_array
  end

  def find_by_id(find_id)
    merchant_array.find {|merchant| merchant.id == find_id }
  end

  def find_by_name(find_name)
    merchant_array.find do |merchant|
      merchant.name.downcase == find_name.downcase
    end
  end

  def find_all_by_name(find_name)
    merchant_array.find_all do |merchant|
      merchant.name.downcase.include?(find_name.downcase)
    end
  end

  def find_items_by_merchant_id(merchant_id)
    @se.find_items_by_merch_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    @se.find_invoices_by_merch_id(merchant_id)
  end

  def find_customer_by_invoice_customer_id(customer_id)
    @se.find_customers_by_id(customer_id)
  end



end
