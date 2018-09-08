require_relative '../lib/merchant'
class MerchantRepository
# The MerchantRepository is responsible for holding and
# searching our Merchant instances.
  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def all
    # Returns an array of all known Merchant instances
  end

  def find_all_by_id(id)
    # Returns either nil or an instance of Merchant with a matching ID
  end

  def find_by_name(name)
    # Returns either nil or an instance of Merchant having done a
    # case insensitive search
  end

  def find_all_by_name
    # Returns either [] or one or more matches which contain the
    # supplied name fragment, case insensitive
  end

  def create(attributes)
    # Attributes is in the form of CSV object. Create extracts the data from
    # that object and creates a new merchant object.
    merchant = Merchant.new({
      id: attributes[:id],
      name: attributes[:name]
      })
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


end
