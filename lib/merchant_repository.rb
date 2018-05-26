require_relative 'sales_engine'
require_relative 'merchant'
require 'CSV'

class MerchantRepository
  attr_reader :merchants

  def initialize(merchants)
    @merchants ||= create_merchant(merchants)
  end

  def create_merchant(merchants)
    merchants.map do |row|
      Merchant.new(row)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    @merchants.find_all { |merchant| merchant.name.downcase.include?(name.downcase) }
  end

  def create(attributes)
    attributes[:id] = generate_id_for_new_merchant
    @merchants << Merchant.new(attributes)
  end

  def generate_id_for_new_merchant
    (@merchants.max_by { |merchant| merchant.id }).id + 1
  end

  def update(id, name)
    return if name.empty?
    merchant_to_update = find_by_id(id)
    merchant_to_update.name = name[:name]
  end

  def delete(id)
    merchant_to_delete = find_by_id(id)
    binding.pry
    @merchants.delete_at(merchant_to_delete)
  end
end
