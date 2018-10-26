require 'pry'
require 'CSV'
require 'time'
require_relative './merchant'
require_relative './repository'

class MerchantRepository < Repository

  def new_record(row)
    Merchant.new(row)
  end

  def find_by_name(name)
    @repo_array.find do |object|
      object.name.upcase == name.upcase
    end
  end

  def find_all_by_name(name)
    @repo_array.select do |merchant|
      merchant.name.upcase.include?(name.upcase)
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
