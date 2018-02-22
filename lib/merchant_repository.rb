require 'csv'
require_relative 'merchant'
require 'pry'

class MerchantRepository

  attr_reader :engine

  def initialize(filepath, parent = nil)
    @merchants   = []
    @engine      = parent
    load_merchants(filepath)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @merchants
  end

  def load_merchants(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data, self)
    end
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_items_by_merchant_id(id)
    engine.find_items_by_merchant_id(id)
  end

end
