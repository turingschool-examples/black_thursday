require './test/test_helper.rb'
require './lib/repository'
require './lib/merchant_repository'
require './lib/merchant'

class RepositoryTest < Minitest::Test

  def setup
    @rep = Repository.new
  end

  def test_it_exists
    assert_instance_of Repository, @rep
  end

  def test_all_returns_an_empty_array_by_default
    assert_equal [], @rep.all
  end

  def test_find_by_id_returns_nil_if_no_items
    assert_nil @rep.find_by_id(1)
  end

  def test_find_by_name_returns_nil_if_no_items
    assert_nil @rep.find_by_name("Name of something")
  end

  def test_find_all_returns_an_empty_array_if_none_found
    assert_equal [], @rep.find_all("name")
  end

  def test_f

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
