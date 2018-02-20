require 'CSV'
require 'pry'
require './lib/merchant'

# Merchant Repository class
class MerchantRepository
  def initialize(filepath, parent)
    @merchants = []
    @parent = parent
    load_merchants(filepath)
  end

  def all
    @merchants
  end

  def load_merchants(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
    @merchants << Merchant.new(data)
    end
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.casecmp(name) }
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.to_s.downcase)
    end
  end
end
