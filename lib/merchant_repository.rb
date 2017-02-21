require 'csv'
require_relative './merchant'

class MerchantRepository
  attr_accessor :merchants_array
  attr_reader :contents, :merchants_path

  def initialize(path)
    @merchants_path = path  # "./data/merchants.csv"
    @contents = contents
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

# MerchantRepository
#
# The MerchantRepository is responsible for holding and searching our Merchant instances. It offers the following methods:
#
# all - returns an array of all known Merchant instances

# find_by_id - returns either nil or an instance of Merchant with a matching ID

# find_by_name - returns either nil or an instance of Merchant having done a case insensitive search

# find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
