require_relative '../lib/merchant'
require 'pry'
class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def inspect
   “#<#{self.class} #{@items.size} rows>”
  end

  def create(attributes)
    if attributes[:id].nil?
      id = @merchants[-1].id + 1
    else
      id = attributes[:id]
    end
    new_merchant = Merchant.new({id: id, name: attributes[:name], created_at: attributes[:created_at], updated_at: attributes[:updated_at]})
    @merchants << new_merchant
    return new_merchant
  end

  def all
    @merchants
  end

  def find_by_id(id)
    matching_merchant = nil
    @merchants.each do |merchant|
      if merchant.id == id
        matching_merchant = merchant
      end
    end
    return matching_merchant
  end

  def find_by_name(name)
    matching_merchant = nil
    @merchants.each do |merchant|
      # require 'pry' ; binding.pry
      if merchant.name.downcase == name.downcase
        matching_merchant = merchant
      end
    end
    return matching_merchant
  end

  def find_all_by_name(name)
    matching_merchants = []
    @merchants.each do |merchant|
      # binding.pry
      if merchant.name.downcase.include?(name.downcase)
        matching_merchants << merchant
      end
    end
    return matching_merchants
  end

  def update(id, attributes)
    updated_merchant = find_by_id(id)
    if updated_merchant.nil?
      return
    else
      updated_merchant.name = attributes[:name]
    end
  end

  def delete(id)
    deleted_merchant = find_by_id(id)
    @merchants.delete(deleted_merchant)
  end


end
