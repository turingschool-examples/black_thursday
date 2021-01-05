require 'time'
require 'csv'

class MerchantRepository
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant[:id].to_i == id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant[:name] == name
    end
  end

  def find_all_by_name(name)
    merchants.find_all do |merchant|
      merchant[:name].downcase.include?(name.downcase)
    end
  end

  def max_merchant_id
    merchants.max_by do |merchant|
      merchant[:id]
    end
  end

  def create(attributes) #needs test
    # could this be inherited from another method?
    # wouldn't this call for Merchant.new(attributes)?
    attributes[:id] = max_item_id + 1
    attributes[:name] = name.to_s
    attributes[:created_at] = Time.strftime("%Y-%m-%d")
    attributes[:updated_at] = Time.now.to_s #replace with above?
  end

  def update(id, attribute)
    find_by_id(id)[:name] = attribute
  end

  def delete(id)
    merchants.delete(id)
  end
end
