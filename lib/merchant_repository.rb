class MerchantRepository
  def initialize
    @merchants = []
  end

  def create(attributes)
    new_merchant = Merchant.new(attributes)
    @merchants << new_merchant
    new_merchant
  end

  def update(current_id, new_attributes)
    merchant = find_by_id(current_id)
    merchant.update_name(new_attributes)
  end

  def delete(id)
    merchant = find_by_id(id)
    @merchants.delete(merchant)
  end

  def find_by_id(id)
    @merchants.detect do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.detect do |merchant|
      merchant.name == name
    end
  end

  def find_all_by_name(name_fragment)
    matches = []
    @merchants.each do |merchant|
      if merchant.name.include?(name_fragment)
        matches << merchant
      end
    end
    return matches
  end

  def all
    @merchants
  end

end
