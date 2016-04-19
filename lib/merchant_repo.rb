require "csv"
require_relative "merchant"

class MerchantRepo
  def initialize
    @all_merchants = Array.new
  end

  def merchants #remove this method, initialize?
    contents = CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol

    @all_merchants = contents.map do |row|
      Merchant.new({:id => row[:id], :name => row[:name]})
    end
  end

  def all
    merchants
  end

  def find_by_id(id)
    @all_merchants.find do |merchant|
      merchants.id == id
    end
  end

  def find_by_name(name)
    @all_merchants.find do |merchant|
      merchants.name.downcase
    end
  end

  def find_all_by_name(name)
    @all_merchants.find_all do |merchant|
      merchant.name.downcase
    end
  end


end
