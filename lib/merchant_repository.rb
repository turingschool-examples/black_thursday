require_relative 'csv_parser'
require_relative 'merchant'
require_relative 'sales_engine'
require 'pry'

class MerchantRepository

  include CsvParser

  attr_reader :all

  def initialize(merchant_data)
    @all = merchant_data.map { |raw_merchant| Merchant.new(raw_merchant, self)}
    
  end

  def find_by_id(id)
    all.find do |merchant| 
      merchant.id == id
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end
 
  def find_all_by_name(fragment)
    # please refactor me /select/
    merchants = all.map do |merchant|
      if merchant.name.downcase.include?(fragment.downcase)
        merchant
      end
    end
    merchants.compact
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end