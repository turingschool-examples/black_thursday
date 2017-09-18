require 'csv'
require_relative 'merchant'
require 'pry'

class MerchantRepo
  attr_reader :merchants, :parent

  def initialize(file,se=nil)
    open_file(file)
    @parent = se
  end

  def open_file(file)
    csv = CSV.foreach file,
    headers: true, header_converters: :symbol
    @merchants = csv.map do |row|
      Merchant.new(row, self)
    end
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def merchant_invoices(id)
    parent.merchant_invoices(id)
  end

  def merchant_items(id)
    parent.merchant_items(id)
  end

  def merchant_customers(id)
    parent.merchant_customers(id)
  end

  def merchants_by_total_revenue
    all.sort_by { |merchant| merchant.total_revenue }.reverse
  end

  def revenue_by_merchant(merchant_id)
    merchants.find { |merch| merch.id == merchant_id }.total_revenue
  end

end
