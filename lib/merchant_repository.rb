require 'csv'
require_relative './sales_engine'
require_relative './merchants'

class MerchantRepository
  def initialize(data)
    @merchants = data
  end

  def all
    @merchants
  end

  def find_by_id(id)
    merchant_id = nil
    @merchants.select do |merchant|
      if merchant.id.to_i == id
        merchant_id = merchant
      end
    end
    merchant_id
  end

  def find_by_name(name)
    merchant_name = nil
    @merchants.find do |merchant|
      if merchant.name.downcase == name.downcase
        merchant_name = merchant
      end
    end
    merchant_name
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      if merchant.name.downcase.include?(name.downcase)
        merchant
      end
    end
  end

  def highest_id
    new = @merchants.max_by(&:id)
    new.id + 1
  end

  def create(attributes)
    new_merch = Merchants.new([highest_id, attributes[:name],Time.now.strftime('%Y-%m-%d'), Time.now.strftime('%Y-%m-%d')])
      @merchants << new_merch
  end

  def update(id, attributes)
    @merchants.map do |merchant|
      if merchant.id == id
        merchant.name = attributes[:name]
        merchant.updated_at = Time.now.strftime('%Y-%m-%d')
      end
    end
  end

  def delete(id)
    trash = @merchants.find do |merchant|
      merchant.id == id
    end
    @merchants.delete(trash)
  end
end
