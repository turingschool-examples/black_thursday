require_relative './merchant'
class MerchantRepository
  attr_reader :all
  def initialize
    @all = []
  end

  def create(info)
    #new merchant id needs to be incremented from the highest present case
     new_merchant = Merchant.new(info)
     @all << new_merchant
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name == name
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name == name
    end
  end

  def update(id, info)
    found = @all.find do |merchant|
      merchant.id == id
    end
    new_hash = found.info.merge!(info)
    new_merchant = Merchant.new(new_hash)
    @all << new_merchant
  end

  def delete(id)
    @all.delete_if do |merchant|
      merchant.id == id
    end
  end
end
