require 'pry'
require 'CSV'
require 'time'
require_relative '../lib/merchant'
require_relative './repo_module'

class MerchantRepository

  include Repository

  attr_reader :repo_array

  def initialize(csv_merchants)
    @repo_array = []
    create_merchant_array(csv_merchants)
  end

  def create_merchant_array(csv_merchants)
    row_objects = CSV.read(csv_merchants, headers: true, header_converters: :symbol)
        @repo_array = row_objects.map do |row|
          Merchant.new(row)
      end
  end

  def find_all_by_name(name)
    @repo_array.find_all do |merchant|
      binding.pry
      merchant.name.upcase == name.upcase
    end
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @repo_array << new_item = Merchant.new(attributes)
    new_item
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    return merchant if merchant.nil?
    merchant.name = attributes[:name] unless attributes[:name].nil?
    merchant
  end

end
