require_relative 'merchant'
require_relative 'repo_module'
class MerchantRepository
  include RepoModule

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def initialize(merchants)
    @merchants = merchants
  end

  def all
    @merchants
  end

  # def find_by_id(id)
  #   @merchants.find { |merchant| merchant.id == id}
  # end

  # def find_by_name(name)
  #   @merchants.find { |merchant| merchant.name.upcase == name.upcase}
  # end

  def find_all_by_name(name)
    @merchants.find_all { |merchant| merchant.name.upcase.include?(name.upcase)}
  end

  def all_ids
    ids = @merchants.map { |merchant| merchant.id}
  end

  def create(attributes)
    ids = all_ids
    attributes[:id] = ids.max + 1
    new_merchant = Merchant.new(attributes)
    @merchants.push(new_merchant)
    new_merchant
  end

  def update(id, attributes)
    if all_ids.include?(id)
      updated_merchant = find_by_id(id)
      updated_merchant.update_name(attributes[:name])
      updated_merchant
    end
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end
end
