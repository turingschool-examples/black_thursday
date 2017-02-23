require "csv"
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize(merchants, parent)
    @merchants = merchants
    @parent = parent
  end

  def all 
      merchants
  end

  def find_by_id(merchant_id)
    merchants[:merchant].find { |row| row.id == merchant_id }
  end

  def find_by_name (merchant_name)
    merchants[:merchant].find { |row| row.name == merchant_name }
  end

  def find_all_by_name (merchant_name)
    merchants[:merchant].select { |row| row.name == merchant_name }
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
