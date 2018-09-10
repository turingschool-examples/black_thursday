require_relative '../lib/merchant'
class MerchantRepository
# The MerchantRepository is responsible for holding and
# searching our Merchant instances.

  def initialize
    @merchants = []
  end

  def inspect
  "#<\#{self.class} \#{@merchants.size} rows>"
  end

  def all
    @merchants
  end

  def find_by_id(number)
    @merchants.find do |merch|
      merch.id == number
    end
  end

  def find_by_name(search_name)
    @merchants.find do |merch|
      merch.name.downcase == search_name.downcase
    end
  end

  def find_all_by_name(search_name)
    @merchants.find_all do |merch|
      merch.name.downcase.include?(search_name.downcase)
    end
  end

  def create(attributes)
    # TODO update
    if attributes.class == String
      merchant = Merchant.new({id: find_next_id, name: attributes})
    else
      merchant = Merchant.new({
        id: attributes[:id],
        name: attributes[:name]
        })
    end
    @merchants << merchant
  end

  def update(id, attributes)
    find_by_id(id).name = attributes
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

  def find_next_id
    max_id = @merchants.max_by do |merch|
      merch.id
    end.id
    max_id += 1
  end
end
