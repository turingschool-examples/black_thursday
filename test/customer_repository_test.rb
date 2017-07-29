require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def test_it_exists
    c = CustomerRepository.new(1)
    assert c
    assert_instance_of CustomerRepository, c
  end


  def test_it_can_be_added_to
    cr = CustomerRepository.new(1)
    hash_one = {id: 2, first_name: "Sid",
                last_name: "Vicious"}
    hash_two = {id: 1, first_name: "Nancy",
                last_name: "Kerrigan"}

    cr.add_data(hash_one)
    cr.add_data(hash_two)

    assert_equal 2        , cr.customers.first.id
    assert_equal "Sid", cr.customers.first.first_name
    assert_equal "Vicious", cr.customers.first.last_name
    assert_equal "Kerrigan" , cr.customers.last.last_name
    assert_equal "Nancy", cr.customers.last.first_name
    assert_equal 1        , cr.customers.last.id
  end

  def setup
    @cust_repo = CustomerRepository.new(self)
    hash_one   = {id: 122, first_name: "Sam", last_name: "Snider"}
    hash_two   = {id: 123, first_name: "Sam", last_name: "Jones"}
    hash_three = {id: 124, first_name: "Bill", last_name: "Hodges"}
    hash_four  = {id: 125, first_name: "Larry", last_name: "Snider"}
    @cust_repo.add_data(hash_one)
    @cust_repo.add_data(hash_two)
    @cust_repo.add_data(hash_three)
    @cust_repo.add_data(hash_four)
  end

  def test_all_is_working
    assert_equal 4        , @cust_repo.all.count
    assert_equal 122      , @cust_repo.all.first.id
    assert_equal "Snider", @cust_repo.all.first.last_name
    assert_equal "Jones", @cust_repo.all[1].last_name
    assert_equal 125      , @cust_repo.all.last.id
  end

  def test_find_by_id_returning_nil_for_non_existing_ids
    assert_nil @cust_repo.find_by_id(14331)
    assert_nil @cust_repo.find_by_id(54322)
  end

  def test_find_by_id_working
    save_one = @cust_repo.find_by_id(123)
    save_two = @cust_repo.find_by_id(125)

    assert_equal @cust_repo.customers[1], save_one
    assert_equal @cust_repo.customers.last, save_two
  end

  def test_find_all_by_first_name_blank
    assert @cust_repo.find_all_by_first_name("John").empty?
  end

  def test_find_all_by_first_name_working_for_entry_entires
    list_one = @cust_repo.find_all_by_first_name("Bill")
    list_two = @cust_repo.find_all_by_first_name("Larry")

    assert_equal 1  , list_one.count
    assert_equal 124, list_one.first.id
    assert_equal 1  , list_two.count
    assert_equal 125, list_two.first.id
  end

  def test_find_all_by_first_name_works_for_multiple_entries
    list = @cust_repo.find_all_by_first_name("Sam")

    assert_equal 2  , list.count
    assert_equal 122, list.first.id
    assert_equal 123, list.last.id
  end


  def test_find_all_by_last_name_blank
    assert @cust_repo.find_all_by_last_name("Spencer").empty?
  end

  def test_find_all_by_last_name_working_for_entry_entires
    list_one = @cust_repo.find_all_by_last_name("Jones")
    list_two = @cust_repo.find_all_by_last_name("Hodges")

    assert_equal 1  , list_one.count
    assert_equal 123, list_one.first.id
    assert_equal 1  , list_two.count
    assert_equal 124, list_two.first.id
  end

  def test_find_all_by_last_name_works_for_multiple_entries
    list = @cust_repo.find_all_by_last_name("Snider")

    assert_equal 2  , list.count
    assert_equal 122, list.first.id
    assert_equal 125, list.last.id
  end
end
