require_relative '../lib/merchant'
require 'csv'
class MerchantRepository

  def initialize(data)
    @collection = data
  end

  def inspect
  end

  def all
    @collection
  end

  def find_by_id(id)
    @collection.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    name_case = name.downcase
    @collection.find do |merchant|
      merchant.name.downcase.include?(name_case)
    end
  end

  def find_all_by_name(name)
    name_case = name.downcase
    @collection.find_all do |merchant|
      merchant.name.downcase.include?(name_case)
    end
  end

  def create(attribute)
    highest = @collection.max_by do |merchant|
      merchant.id
    end
    number = highest.id + 1
    new_merchant = Merchant.new({ id: number, name: attribute[:name] })
    @collection << new_merchant
    new_merchant
  end

  def update(id, data)
    if find_by_id(id) == nil
    else
        find_by_id(id).name = data[:name]
    end
  end

  def delete(id)
    @collection.delete_if do |merchant|
      merchant.id == id
    end
  end
end
