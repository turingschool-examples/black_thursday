class MerchantRepository
# The MerchantRepository is responsible for holding and searching our Merchant instances.

  def initialize(hash) #takes in hash
  end

  def all
    # returns an array of all known Merchant instances
  end

  def find_by_id(id)
    # returns either nil or an instance of Merchant with a matching ID
  end

  def find_by_name(name)
    # returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_all_by_name(name)
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end

  def create(attributes)
    # create a new Merchant instance with the provided attributes. The new Merchant’s id should be the current highest Merchant id plus 1.
  end

  def update_id(id, attributes)
    # update the Merchant instance with the corresponding id with the provided attributes. Only the merchant’s name attribute can be updated.
  end

  def delete(id)
    # delete the Merchant instance with the corresponding id. The data can be found in data/merchants.csv so the instance is created and used like this:
  end
end
