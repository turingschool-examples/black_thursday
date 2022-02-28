require "pry"

class MerchantRepository
  attr_reader :merchants_instances_array
  def initialize(merchants_instances_array)
    @merchants_instances_array = merchants_instances_array
  end

  def all
    merchants_instances_array
  end

  def find_by_id(id)
    merchants_instances_array.find do |merchant_instance|
      merchant_instance.merchant_attributes[:id] == id
    end
  end

  def find_by_name(name)
    merchants_instances_array.find do |merchant_instance|
      merchant_instance.merchant_attributes[:name] == name.downcase
    end
  end

  def find_all_by_name(fragment)
    merchants_instances_array.find_all do |merchant_instance|
      merchant_instance.merchant_attributes[:name].include?(fragment)
    end
  end

  def create(attributes)
    attributes[:id] = merchants_instances_array[-1].merchant_attributes[:id] + 1
    merchants_instances_array << Merchant.new(attributes)
  end

  def update(id, attributes)
    if attributes.include?(:name)
      find_by_id(id).merchant_attributes[:name] = attributes[:name]
    end
    if attributes.include?(:created_at)
      find_by_id(id).merchant_attributes[:created_at] = attributes[:created_at]
    end
    if attributes.include?(:updated_at)
      find_by_id(id).merchant_attributes[:updated_at] = attributes[:updated_at]
    end
  end

  def delete(id)
    merchants_instances_array.delete(find_by_id(id))
  end
end
