require 'pry'
require_relative './merchant'

class MerchantRepository

  def initialize
    @merchants = []
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
      merchant.name == name
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.include?(name)
    end
  end

  def create_with_id(attributes)
    merchant = Merchant.new(attributes)
    @merchants << merchant
    merchant
  end

  def create_without_id(attributes)
    merchant = Merchant.create(attributes)
    @merchants << merchant
    merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    # require 'pry' ; binding.pry
    merchant.name = attributes
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

end
