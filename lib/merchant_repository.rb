require './lib/merchant'

class MerchantRepository
  attr_reader :all
  def initialize
    @all = []
  end

  def add_merchant(merchant_object)
    @all << merchant_object
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      name.casecmp(merchant.name) == 0
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      name.casecmp(merchant.name) == 0
    end
  end

  def create(attributes)
    new = Merchant.new(attributes)
    new.id = @all.max_by do |merchant|
      merchant.id
    end.id + 1
    new
  end

  def update(id, attributes)
     update_merchant = find_by_id(id)
     update_merchant.name = attributes
  end

  def delete(id)
    delete_merchant = find_by_id(id)
    @all.delete(delete_merchant)
  end
end
