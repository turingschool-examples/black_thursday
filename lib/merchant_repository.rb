# frozen_string_literal: true

require './lib/merchant'

# Merchant repository class
class MerchantRepository
  def initialize
    @merchants = []
  end

  def create(params)
    Merchant.new(params).tap do |merchant|
      @merchants << merchant
    end
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

  def update(id, params)
    new_name = params[:name]
    merchant = find_by_id(id)
    merchant.name = new_name
    merchant
  end

  def delete(id)
    merchant = find_by_id(id)
    @merchants.delete(merchant)
  end
end
