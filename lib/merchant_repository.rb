require_relative 'merchant'
require_relative 'sales_engine'
require_relative 'item_repository'
require_relative 'item'
require_relative 'csv_parser'
require 'pry'

class MerchantRepository

  include CsvParser

  attr_reader :all,
              :parent

  def initialize(merchant_data, parent)
    @all = merchant_data.map { |raw_merchant| Merchant.new(raw_merchant, self)}
    @parent = parent
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
    merchants = all.find_all do |merchant|
      merchant.name.downcase.include?(fragment.downcase)
    end
  end

  def inspect
     # ????
    "#<#{self.class} #{@merchants.size} rows>"
  end
end