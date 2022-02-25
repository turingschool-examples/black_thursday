require 'pry'
class MerchantRepository
  def initialize(merchants)
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
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

#helper method for create
  def highest_id
    last_id = 0
    @merchants.max do |merchant|
      last_id = merchant.id
    end
    return last_id
  end

  def create(attributes)
    attributes[:name] = Merchant.new({:id => self.highest_id + 1, :name => attributes[:name]})
  end

  def update(id, attributes)
    new_name = self.find_by_id(id)
    new_name.name = attributes[:name]
    return new_name
  end

  def delete(id)
    erase = self.find_by_id(id)
    @merchants.delete(erase)
  end
end
