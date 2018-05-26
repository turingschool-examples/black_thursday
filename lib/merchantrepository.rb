require 'pry'
class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def create(attributes)
    new_id = @merchants[-1].id.to_i + 1
    new_merchant = Merchant.new({id: new_id.to_s, name: attributes[:name]})
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
    find_by_id(id) = nil
    @merchants.compact
  end 


end
