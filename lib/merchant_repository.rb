require_relative '../lib/merchant'
class MerchantRepository
# The MerchantRepository is responsible for holding and
# searching our Merchant instances.

  def initialize
    @merchants = []
  end

  def all
    @merchants
  end

  def find_all_by_id(number)
    # Returns either nil or an instance of Merchant with a matching ID
    @merchants.find do |merch|
      merch.id == number
    end
  end

  def find_by_name(search_name)
    # Returns either nil or an instance of Merchant having done a
    # case insensitive search
    @merchants.find do |merch|
      merch.name.downcase == search_name.downcase
    end
  end

  def find_all_by_name(search_name)
    # Returns either [] or one or more matches which contain the
    # supplied name fragment, case insensitive
    @merchants.find_all do |merch|
      merch.name.downcase.include?(search_name.downcase)
    end

  end

  def create(attributes)
    # Attributes is in the form of CSV object. Create extracts the data from
    # that object and creates a new merchant object.
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
    # Update the Merchant instance with the corresponding id with
    # the provided attributes.
    # Only the merchant’s name attribute can be updated.
  end

  def delete(id)
    # Delete the Merchant instance with the corresponding id
  end


  def find_next_id
    max_id = @merchants.max_by do |merch|
      merch.id
    end.id
    max_id += 1
  end

end
