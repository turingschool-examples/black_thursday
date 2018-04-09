# frozen_string_literal: true

# holds, and provides methods for finding, merchants
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

  def find_highest_id
    @merchants.max_by{|merchant| merchant.id}
  end

  def create(name)
    @merchants << Merchant.new(id: (find_highest_id.id + 1), name: name)
  end

  def update(attributes)
    find_by_id[attributes[id]]
  end 
end
