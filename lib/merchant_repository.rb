require_relative "merchant"
require "csv"
require 'pry'

class MerchantRepository
  attr_reader :merchants

  def initialize(file)
    @merchants = from_csv(file)
  end

  def from_csv(file)
    merchant_list = []
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      merchant_info = {}
      merchant_info[:id] = row[:id]
      merchant_info[:name] = row[:name]
      merchant_info[:created_at] = row[:created_at]
      merchant_info[:updated_at] = row[:updated_at]
      merchant_list << Merchant.new(merchant_info)
    end
    merchant_list
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @merchants.find {|merchant| merchant.name == name}
  end

  def find_all_by_name(name)
    @merchants.find_all {|merchant| merchant.name.include?(name)}
  end

end
