class MerchantRepository
  attr_reader :merchants
  def initialize
    @merchants = []
  end

  def create(attributes)
    merchants << Merchant.new(attributes)
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
    end
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
    merchants.delete_if{|merchant| merchant.id.include?(id) }
  end
end