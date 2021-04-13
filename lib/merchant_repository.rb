require './lib/merchant'

class MerchantRepository
  def initialize(merchants = [])
    @merchants = merchants
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
      merchant.name == name
    end
  end

  def delete(id)
    index = @merchants.index do |merchant|
      merchant.id == id
    end
    @merchants.delete_at(index)
  end

  def newest_id
    merchant = @merchants.max_by(&:id)
    merchant.id + 1
  end

  def create(attributes)
    merchant = Merchant.new(
    {
      id: newest_id,
      name: attributes[:name]
    })
    @merchants << merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.update_name(attributes[:name])
  end
end
