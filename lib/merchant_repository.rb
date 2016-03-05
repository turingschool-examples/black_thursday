require_relative 'sales_engine'
require_relative 'merchant'
require 'csv'
require 'pry'

class MerchantRepository
  attr_reader :merchants, :sales_engine
  def initialize(value_at_merchant, sales_engine)
    # takes in an array of hashes where each hash represents data
    # for a single merchant
    # merchants have [:id, :name, :......]
    @sales_engine = sales_engine
    @merchants = []
    make_merchants(value_at_merchant)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def make_merchants(merchant_hashes)
    #@merchants = value_at_merchant.map { |merchant_row| Merchant.new(merchant_row)}
    merchant_hashes.each do |merchant_hash|
      @merchants << Merchant.new(merchant_hash, self)
    end
  end

  def find_items(id)
    @sales_engine.items.find_all_by_merchant_id(id)
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
