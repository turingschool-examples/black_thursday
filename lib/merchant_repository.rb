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

  def create(attributes)
    @merchants << Merchant.create(attributes)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name = attributes
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

end
