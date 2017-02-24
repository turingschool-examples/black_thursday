require "csv"
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants, :parent

  def initialize(merchants, parent = nil)
    @merchants = merchants
    @parent = parent
  end

  def all
      merchants
  end

  def find_by_id(merchant_id)
    merchants.find { |row| row.id == merchant_id }
  end

  def find_by_name (merchant_name)
    merchants.find { |row| row.name.downcase == merchant_name.downcase }
  end

  def find_all_by_name (merchant_name)
    merchants.select { |row| row.name.downcase.include? (merchant_name.downcase) }
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
