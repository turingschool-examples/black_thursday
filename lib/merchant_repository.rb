# frozen_string_literal: true

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
      merchant_id = merchant if merchant.id.to_i == id
    end
    merchant_id
  end

  def find_by_name(name)
    merchant_name = nil
    @merchants.find do |merchant|
      merchant_name = merchant if merchant.name.downcase == name.downcase
    end
    merchant_name
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant if merchant.name.downcase.include?(name.downcase)
    end
  end

  def highest_id
    new = @merchants.max_by(&:id)
    new.id + 1
  end

  def create(attributes)
    new_merch = [highest_id,
                 attributes[:name],
                 Time.now.strftime('%Y-%m-%d'),
                 Time.now.strftime('%Y-%m-%d')]
    new = Merchant.new(new_merch)
    @merchants << new
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
