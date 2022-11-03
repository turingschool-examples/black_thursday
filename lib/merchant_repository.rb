class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = []
  end

def create(attributes)
  if merchants.last.nil? == false
    attributes[:id] = (@merchants.last.id + 1)
  end
  new_merchant = Merchant.new(attributes)
  @merchants << new_merchant
  new_merchant

end

  def all
    @merchants
  end

  def find_by_id(id)
    merchants.find {|merchant| merchant.id == id}
   end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    merchants.select do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def delete(id)
    merchants.delete_if{|merchant| merchant.id. == id }
  end

  def update(id, attributes)
    updated_merchant = find_by_id(id)
    updated_merchant.name = attributes
  end
end