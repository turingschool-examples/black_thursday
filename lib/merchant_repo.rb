require_relative 'merchant'
require_relative 'sales_engine'

class MerchantRepository
  def self.read_merchants_file(merchants, sales_engine)
    merchant_list = []
    CSV.foreach(merchants, headers: true, header_converters: :symbol) do |row|
      id = row[:id]
      name = row[:name]
      merchant_list << Merchant.new({ :id => id, :name => name})
    end
    MerchantRepository.new(merchant_list,sales_engine)
  end

  attr_reader :merchants, :sales_engine

  def initialize(merchant_list, sales_engine)
    @merchants = merchant_list
    @sales_engine = sales_engine
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

  def find_all_by_name(fragment)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(fragment.downcase)
    end
  end

  def merchant_items(merchant_id)
    require 'pry'; binding.pry
    sales_engine.find_merchant_items(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
