
require_relative './merchant'
class MerchantRepository
  def initialize(filepath)
    @merchants = []
    load_merchants(filepath)
  end

  def all
    @merchants
  end

  def load_merchants(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol ) do |data|
      @merchants << Merchant.new(data)
    end
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(new_merchant)
    highest_id = @merchants.max_by do |merchant|
      merchant.id
    end.id
    new_merchant_id = highest_id += 1
    new_merchant = Merchant.new(id: new_merchant_id, name: new_merchant[:name])
    @merchants << new_merchant
    return new_merchant
  end

  def update(id, attributes)
    @merchants.find do |merchant|
      if merchant.id == id
      merchant.name.gsub! merchant.name, attributes[:name]
      end
    end
  end

  def delete(id)
    merchant = find_by_id(id)
    @merchants.delete(merchant)
  end
end
