require_relative '../sales_engine'
require_relative 'merchant'
require 'csv'
require 'pry'

class MerchantRepository
  attr_reader :id, :name, :created_at, :updated_at
  #se.merchants -- merchants is salesengine method
  def initialize(value_at_merchant)
    make_merchants(value_at_merchant)
    # @id = value[:id]
    # @name = value[:name]
    # @created_at = value[:created_at]
    # @updated_at = value[:updated_at]
  end

  def make_merchants(merchant_hashes)
    @merchants = []
    merchant_hashes.each do |merchant_hash|
      @merchants << Merchant.new(merchant_hash)
    end
    @merchants
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |hash| hash[:id] == id }
  end
  def find_by_name(name)
    # @merchants[name]
    @merchants.find { |hash| hash.value(:name) == name}
  end
  def find_all_by_name(name)
        @merchants.find_all { |hash| hash.value(:name) == name}
  end
end
