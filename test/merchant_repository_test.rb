# MerchantRepository

require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @mr = MerchantRepository.new
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

end

# - all - returns an array of all known Merchant instances
# - find_by_id(id) - returns either nil or an instance of Merchant with a matching ID
# - find_by_name(name) - returns either nil or an instance of Merchant having done a case insensitive search
#
# - find_all_by_name(name) - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
# - create(attributes) - create a new Merchant instance with the provided attributes. The new Merchant’s id should be the current highest Merchant id plus 1.
# - delete(id) - delete the Merchant instance with the corresponding id

#slightly unique
# - update(id, attributes) - update the Merchant instance with the corresponding id with the provided attributes. Only the merchant’s name attribute can be updated.


# ItemRepository
#
# - all - returns an array of all known Item instances
# find_by_id(id) - returns either nil or an instance of Item with a matching ID
# - find_by_name(name) - returns either nil or an instance of Item having done a case insensitive search
#
# - find_all_with_description(description) - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
# - find_all_by_price(price) - returns either [] or instances of Item where the supplied price exactly matches
# - find_all_by_price_in_range(range) - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# - find_all_by_merchant_id(merchant_id) - returns either [] or instances of Item where the supplied merchant ID matches that supplied
# - create(attributes) - create a new Item instance with the provided attributes. The new Item’s id should be the current highest Item id plus 1.
# - update(id, attributes) - update the Item insta
