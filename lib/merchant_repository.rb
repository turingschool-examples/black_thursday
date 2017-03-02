require "csv"
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants, :sales_engine

  def initialize(merchants, sales_engine = nil)
    @merchants = merchants
    @sales_engine = sales_engine
  end

  def all
      merchants
  end

  def find_by_id (merchant_id)
    merchants.find { |row| row.id == merchant_id }
  end

  def find_by_name (merchant_name)
    merchants.find { |row| row.name.downcase == merchant_name.downcase }
  end

  def find_all_by_name (merchant_name)
    merchants.select {|row| row.name.downcase.include? (merchant_name.downcase)}
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
