require "csv"
require_relative "merchant"

class MerchantRepo
  attr_reader :all_merchants

  def initialize
    @all_merchants = load_csv
  end

  def load_csv #remove this method, initialize?
    contents = CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol

    result = contents.map do |row|
      Merchant.new({:id => row[:id], :name => row[:name]})
    end
    result
  end

  def all
    @all_merchants
  end

  def find_by_id(id)
    @all_merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all_merchants.find do |merchant|
      merchant.name.downcase
    end
  end

  def find_all_by_name(name)
    @all_merchants.find_all do |merchant|
      merchant.name.downcase
    end
  end


end
