require_relative 'merchant'
require_relative 'test_module'
class MerchantRepository
  include TestModule
  def initialize(merchants)
    @merchants = merchants
  end

  def all
    @merchants
  end

  # def find_by_id(id)
  #   @merchants.find { |merchant| merchant.id == id}
  # end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.upcase == name.upcase}
  end

  def find_all_by_name(name)
    @merchants.find_all { |merchant| merchant.name.upcase == name.upcase}
  end

  def create(attributes)
    ids = @merchants.map { |merchant| merchant.id}
    attributes[:id] = ids.max + 1
    new_merchant = Merchant.new(attributes)
    @merchants.push(new_merchant)
    new_merchant
  end

  def update(attributes)
    updated_merchant = find_by_id(attributes[:id])
    updated_merchant.update_name(attributes[:name])
    updated_merchant
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end
end
