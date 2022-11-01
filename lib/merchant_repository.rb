# This is the MerchantRepository Class
# frozen_string_literal: true.

class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def create(data)
    data[:id] ||= 1 if merchants == []
    data[:id] ||= (@merchants.last.id.to_i + 1).to_s
    @merchants << Merchant.new(data)
  end

  def all
    @merchants
  end

  def find_by_id(id)
    merchants.select { |merchant| merchant.id == id }.first
  end

  def find_by_name(name)
    merchants.select { |merchant| merchant.name.casecmp?(name) }.first
  end

  def find_all_by_name(name)
    merchants.select { |merchant| merchant.name.downcase.include? name.downcase }
  end

  def update(id, name)
    merchant = find_by_id(id)
    merchant.update(name)
  end

  def delete(id)
    to_be_deleted = find_by_id(id)
    @merchants.delete(to_be_deleted)
  end
end
