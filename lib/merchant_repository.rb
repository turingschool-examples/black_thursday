require_relative 'merchant'
require 'pry'
class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = []
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
      merchant.name.downcase.include?(name.downcase)
    end
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

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
