require_relative './merchant'

class MerchantRepository

  def initialize
    @merchants = []
  end

  def all
    @merchants
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
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

  def create_with_id(attributes)
    merchant = Merchant.new(attributes)
    @merchants << merchant
    merchant
  end

  def create(attributes)
    merchant = Merchant.create(attributes)
    @merchants << merchant
    merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name = attributes[:name] unless merchant.nil?
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

end
