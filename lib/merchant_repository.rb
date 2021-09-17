require 'csv'
require_relative './sales_engine'
require_relative './merchants'

class MerchantRepository < Merchants
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
    @merchants.select do |merchant|
      if merchant.name == name
        merchant_name = merchant
      end
    end
    merchant_name
  end

  def find_all_by_name(name)
    merchant_names = []
    @merchants.each do |merchant|
      if merchant.name.include(name)
        merchant_names << merchant
      end
    end
    merchant_names
  end

  def create(attributes)
    # @merchants << Merchant.new([
    #   merchants.id.max += 1, attributes, Time.now, Time.now
    #   ])
  end

  def updates(id, attributes)
    @merchants.id.name = attributes
    @merchants.updated_at = Time.now
  end

  def delete(id)
    @merchants.select do |merchant|
      if merchant.id.to_i == id
        merchant = nil
      end
    end
  end
end
