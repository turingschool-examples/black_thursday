# frozen_string_literal: true

require_relative './merchant'

# ./lib/merchant_repository
class MerchantRepository
  attr_reader :merchants
  def initialize
    @merchants = []
  end

  def all
    @merchants
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant_name = merchant.name.downcase
      merchant_name == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant_name = merchant.name.downcase
      merchant_name.include?(name.downcase)
    end
  end

  def create_with_id(attributes)
    @merchants << Merchant.new(attributes)
  end

  def create(attributes)
    @merchants << Merchant.create(attributes)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name = attributes[:name] unless merchant.nil?
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end
end
