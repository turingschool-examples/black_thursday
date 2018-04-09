require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :path,
              :merchants

  def initialize
    @merchants = []
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    found = merchants.map do |merchant|
      if merchant.name.downcase.include?(name.downcase)
        merchant.name
      end
    end
    found.compact
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
