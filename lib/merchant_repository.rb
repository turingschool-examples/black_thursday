
require_relative './repository'

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

  def create(name)
    add_merchant(Merchant.new({id: find_new_id, name: name}))
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
