require 'csv'
require_relative './merchant'

class MerchantRepository
  attr_accessor :merchants_array
  attr_reader :contents

  def initialize(path)
    @merchants_path = path
    @merchants_array = []
  end

  def pull_csv
    @contents = CSV.open @merchants_path, headers: true, header_converters: :symbol
  end

  def parse_csv
    @contents.each do |row|
      name = row[:name]
      id = row[:id]
      merchants_array << Merchant.new({:id => id.to_i, :name => name})
    end
  end

  def all
    merchants_array
  end

  def find_by_id(find_id)
    merchants_array.find do |instance|
      instance.merchant_hash[:id] == find_id
    end
  end

  def find_by_name(find_name)
    merchants_array.find do |instance|
      instance.merchant_hash[:name].downcase == find_name.downcase
    end
  end

  def find_all_by_name(find_fragment)
    merchants_array.find_all do |instance|
      instance.merchant_hash[:name].downcase.include?(find_fragment.downcase)
    end
  end
end
