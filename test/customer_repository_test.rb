require_relative 'test_helper'

require_relative '../lib/sales_engine'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerRepositoryTest < Minitest::Test

  def setup
    path = {:customers => './data/customers.csv'}
    @repo = SalesEngine.from_csv(path).customers
    # 1,Joey,Ondricka,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    customer_1_hash = { :"1" => { first_name: "Joey",
                                  last_name:  "Ondricka",
                                  created_at: "2012-03-27 14:54:09 UTC",
                                  updated_at: "2012-03-27 14:54:09 UTC"
                                 } }
    @key = customer_1_hash.keys.first
    @values = customer_1_hash.values.first
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @repo
  end

  def test_it_gets_attributes
    # --- Read Only ---
    assert_instance_of Array, @repo.all
    assert_instance_of Customer, @repo.all[0]
    assert_equal @repo.all.count, @repo.all.uniq.count
    assert_equal 1000, @repo.all.count
  end

  def test_it_makes_customers
    # This test is skipped because it will affect other tests.
    skip
    @repo.make_customers
    assert_equal 1000 * 2, @repo.all.count
  end

  def test_it_makes_a_formatted_hash
    # -- The new hash needs an additional column --
    new_column = {:id => 1}
    new_hash = new_column.merge(@values.dup)
    assert_equal new_hash, @repo.make_hash(@key, @values)
  end


  # --- Find By ---

  def test_it_can_find_a_customer_by_id
    assert_nil @repo.find_by_id(000)
    found = @repo.find_by_id(1)
    assert_instance_of Customer, found
    assert_equal 1, found.id
  end

  def test_it_can_find_all_customers_by_first_name_fragment
    assert_equal [], @repo.find_all_by_first_name("zzz")
    found = @repo.find_all_by_first_name("Joey")
    assert_instance_of Array, found
    assert_instance_of Customer, found.first
    assert_equal "Joey", found.first.first_name
  end

  def test_it_can_find_all_customers_by_last_name_fragment
    assert_equal [], @repo.find_all_by_last_name("zzz")
    found = @repo.find_all_by_last_name("Ondricka")
    assert_instance_of Array, found
    assert_instance_of Customer, found.first
    assert_equal "Ondricka", found.first.last_name
  end

  def test_it_can_CREATE_new_customers
    assert_equal 1000, @repo.all.count

    hash = {
      invoice_id:         "9999",
      credit_card_number: "4068631943231473",
      credit_card_expiration_date: "0217",
      result:             "success",
      created_at:         "2012-02-26 20:56:56 UTC",
      updated_at:         "2012-02-26 20:56:56 UTC"
    }

    @repo.create(hash)
    assert_equal 1001, @repo.all.count
  end

  


end
