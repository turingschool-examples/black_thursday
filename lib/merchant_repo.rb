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
end
