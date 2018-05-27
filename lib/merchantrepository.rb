require_relative '../lib/merchant'
class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def create(attributes)
    new_merchant = Merchant.new({id: attributes[:id], name: attributes[:name], created_at: attributes[:created_at], updated_at: attributes[:updated_at]})
    @merchants << new_merchant
    return new_merchant
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.each do |merchant|
      if merchant.id == id
        return merchant
        break
      else
        return nil
      end
    end
  end

  def find_by_name(name)
    @merchants.each do |merchant|
      if merchant.name == name
        return merchant
        break
      else
        return nil
      end
    end
  end

  def find_all_by_name(name)
    matching_merchants = []
    @merchants.each do |merchant|
      if merchant.name.include?(name)
        matching_merchants << merchant
      end
    end
    return matching_merchants
  end

  def update(id, attributes)
    find_by_id(id).name = attributes
  end

  def delete(id)
    deleted_merchant = find_by_id(id)
    @merchants.delete(deleted_merchant)
  end


end
