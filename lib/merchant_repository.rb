require_relative './repository'
require_relative './merchant'

class MerchantRepository < Repository

  def new_record(row)
    Merchant.new(row)
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @all << new_item = Merchant.new(attributes)
    new_item
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    return merchant if merchant.nil?
    merchant.name = attributes[:name] unless attributes[:name].nil?
    merchant
  end

end
