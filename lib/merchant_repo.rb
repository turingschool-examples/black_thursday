require_relative './merchant'
require "time"
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
      if merchant.name.downcase.include?(name.downcase)
        merchant
      end
    end
  end

  def create(attributes)
    max_merchant_id = @merchants.max_by do |merchant|
      merchant.id
    end
    new_max_id = max_merchant_id.id + 1
    merchant_new = Merchant.new(
      id: new_max_id,
      name: attributes[:name],
      created_at: Time.now,
      updated_at: Time.now
    )
    @merchants << merchant_new
    merchant_new
  end

  def update(id, attributes)
    merchant_to_change = find_by_id(id)
    return if merchant_to_change.nil?
      merchant_to_change.updated_at = Time.now
      merchant_to_change.name = attributes[:name]
      merchant_to_change
  end

  def delete(id)
    merchant_to_delete = find_by_id(id)
    @merchants.delete(merchant_to_delete)
  end

end
