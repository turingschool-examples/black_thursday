require "csv"
require_relative "merchant"

class MerchantRepo
  attr_reader :all_merchants

  def initialize(file_name)
    @all_merchants = load_csv(file_name)
  end

  def load_csv(file_name)
    contents = CSV.open file_name, headers: true, header_converters: :symbol

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
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @all_merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

end
