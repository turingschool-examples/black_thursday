class MerchantRepo
  attr_accessor :merchants

  def initialize
    @merchants = []
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant[:id] == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant[:name] == name
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant[:name] == name
    end
  end

  def create(attributes)
    merchant_new = Merchant.new(attributes) #refactor with module?
    max_merchant_id = @merchants.max_by do |merchant|
      merchant[:id]
    end
    new_max_id = max_merchant_id[:id] + 1
    merchant_new.id = new_max_id
    @merchants << merchant_new
    return merchant_new
  end

  def update(id, attributes)
    merchant_to_change = find_by_id(id)
    merchant_to_change[:name] = attributes[:name] 
    merchant_to_change 
  end

  def delete(id)
    merchant_to_delete = find_by_id(id)
    @merchants.delete(merchant_to_delete)
  end
  
end
