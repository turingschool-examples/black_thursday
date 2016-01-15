require 'pry'
require 'csv'
require 'set'
require_relative 'merchant'

class MerchantRepository

  def initialize(merchants)
    parse_merchants(merchants)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def parse_merchants(merchants)
    @merchant_array = []
    merchants.each do |row|
      id   = row[:id]
      name = row[:name]

      @merchant_array << Merchant.new({:id => id, :name => name})
    end
  end

  def all
    @merchant_array
  end

  def find_all_by_name(fragment)
    fragment = fragment.downcase
    @merchant_array.select do |merchant|
      if merchant.name.downcase.include?(fragment)
        merchant.name
      end
    end
  end

  def find_by_name(merchant_name)
    if name_object = @merchant_array.find { |n| n.name.downcase == merchant_name.downcase}
      name_object
    else
      nil
    end
  end

  def find_by_id(merchant_id)
    if id_object = @merchant_array.find { |i| i.id == merchant_id}
      id_object
    else
      nil
    end
  end

end

if __FILE__ == $0

end
