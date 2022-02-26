require "pry"

class MerchantRepository
  attr_reader :attributes
  def initialize(merchants_instances_array)
    @merchants_instances_array = merchants_instances_array
  end

  def all
    @merchants_instances_array
  end

  def find_by_id(id)
    @merchants_instances_array.find do |merchant_instance|
      merchant_instance.merchant_attributes[:id] == id
    end
  end

  def find_by_name(name)
    @merchants_instances_array.find do |merchant_instance|
      merchant_instance.merchant_attributes[:name] == name.downcase
    end
  end

  def find_all_by_name(fragment)
    @merchants_instances_array.find_all do |merchant_instance|
      merchant_instance.merchant_attributes[:name].include?(fragment)
    end
  end

  def create(attributes)
    @merchants_instances_array << Merchant.new(attributes, id: @merchants_instances_array)
  end
  # see black thursday site for method descriptions
end
