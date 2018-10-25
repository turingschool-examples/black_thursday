require_relative './repository'
require_relative './merchant'

class MerchantRepository < Repository

  def initialize
    @collection = {}
  end

  def add_merchant(merchant)
    @collection[merchant.id] = merchant
  end

  def merchants
    @collection.values
  end

  def create(attributes)
    attributes[:id] = find_new_id
    add_merchant(Merchant.new(attributes))
  end

  def update(id, attributes)
    merchant_to_update = find_by_id(id)
    merchant_to_update.name = attributes[:name] unless merchant_to_update == nil
  end

  def find_all_by_name(name)
     merchants_by_name = []
    @collection.values.find_all do |merchant|
      if merchant.name.downcase.include?(name)
        merchants_by_name << merchant
      end
    end
    merchants_by_name
  end
end
