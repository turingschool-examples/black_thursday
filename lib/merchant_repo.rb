require_relative './merchant'
require "pry"

class MerchantRepo

  attr_accessor :merchants

  def initialize(merchants)
    @merchants = merchants
    change_merchant_hashes_to_objects
  end

  def all
    @merchants
  end

  def change_merchant_hashes_to_objects
    object_array = []
    @merchants.each do |hash|
      object_array << Merchant.new(hash)
    end
    @merchants = object_array
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def create(attributes)
    merchant_new = Merchant.new(attributes)
    max_merchant_id = @merchants.max_by do |merchant|
      merchant.id
    end
    new_max_id = max_merchant_id.id + 1
    merchant_new.id = new_max_id
    @merchants << merchant_new
    return merchant_new
  end

  def update(id, attributes)
    merchant_to_change = find_by_id(id)
    merchant_to_change.name = attributes[:name]
  end

  def delete(id)
    merchant_to_delete = find_by_id(id)
    @merchants.delete(merchant_to_delete)
  end

end
