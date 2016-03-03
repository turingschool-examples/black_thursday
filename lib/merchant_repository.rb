require_relative 'sales_engine'
require_relative 'merchant'
require 'csv'
require 'pry'

class MerchantRepository
  attr_reader :merchants, :sales_engine
  def initialize(value_at_merchant, sales_engine)
    @sales_engine = sales_engine
    @merchants = []
    make_merchants(value_at_merchant)
  end
#@merchants = value_at_merchant.map { |merchant_row| Merchant.new(merchant_row)}

  def make_merchants(merchant_hashes)
    merchant_hashes.each do |merchant_hash|
      @merchants << Merchant.new(merchant_hash, self)
    end
  end

  def find_items
    sales_engine.items
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |object| object.id == id }
  end

  def find_by_name(name)
    @merchants.find { |object| object.name.downcase == name.downcase}
  end

  def find_all_by_name(name_fragment)
    @merchants.find_all { |object| object.name.downcase.include?(name_fragment.downcase)}
  end
end
