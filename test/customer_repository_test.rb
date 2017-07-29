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

  # def test_find_by_id_returning_nil_for_non_existing_ids
  #   assert_nil @invoice_r.find_by_id(14331)
  #   assert_nil @invoice_r.find_by_id(54322)
  # end
  #
  # def test_find_by_id_working
  #   save_one = @invoice_r.find_by_id(123)
  #   save_two = @invoice_r.find_by_id(125)
  #
  #   assert_equal @invoice_r.invoices[1], save_one
  #   assert_equal @invoice_r.invoices.last, save_two
  # end

  #
  # def setup
  #   @invoice_r = CustomerRepository.new(self)
  #   hash_one   = {id: 122, first_name: "Sam", last_name: "Snider"}
  #   hash_two   = {id: 123, first_name: "Sam", last_name: "Jones"}
  #   hash_three = {id: 124, first_name: "Bill", last_name: "Hodges"}
  #   hash_four  = {id: 125, first_name: "Larry", last_name: "Snider"}
  #   @invoice_r.add_data(hash_one)
  #   @invoice_r.add_data(hash_two)
  #   @invoice_r.add_data(hash_three)
  #   @invoice_r.add_data(hash_four)
  # end



# def test_all_is_working
#   assert_equal 4        , @invoice_r.all.count
#   assert_equal 123      , @invoice_r.all.first.id
#   assert_equal :shipped, @invoice_r.all.first.status
#   assert_equal :pending, @invoice_r.all[1].status
#   assert_equal 125      , @invoice_r.all.last.id
# end
#
# def test_find_by_id_returning_nil_for_non_existing_ids
#   assert_nil @invoice_r.find_by_id(14331)
#   assert_nil @invoice_r.find_by_id(54322)
# end
#
# def test_find_by_id_working
#   save_one = @invoice_r.find_by_id(123)
#   save_two = @invoice_r.find_by_id(125)
#
#   assert_equal @invoice_r.invoices[1], save_one
#   assert_equal @invoice_r.invoices.last, save_two
# end
#
# def test_find_all_by_customer_id_returns_blank_if_none_match
#   assert_equal [], @invoice_r.find_all_by_customer_id(120)
#   assert_equal [], @invoice_r.find_all_by_customer_id(12032)
# end
#
# def test_find_all_by_customer_id_works_for_one_entry
#   list_one = @invoice_r.find_all_by_customer_id(3)
#   list_two = @invoice_r.find_all_by_customer_id(2)
#
#   assert_equal 1        , list_one.count
#   assert_equal :shipped, list_one.first.status
#   assert_equal 125      , list_one.first.id
#
#   assert_equal 1        , list_two.count
#   assert_equal :pending, list_two.first.status
#   assert_equal 123      , list_two.first.id
# end
#
# def test_find_all_by_customer_id_works_for_multiple_entries
#   list = @invoice_r.find_all_by_customer_id(1)
#
#   assert_equal 2        , list.count
#   assert_equal :shipped, list.first.status
#   assert_equal 7        , list.first.merchant_id
#   assert_equal :shipped, list.last.status
#   assert_equal 5        , list.last.merchant_id
# end
#
# def test_find_all_by_merchant_id_returns_blank_if_none_match
#   assert_equal [], @invoice_r.find_all_by_merchant_id(120)
#   assert_equal [], @invoice_r.find_all_by_merchant_id(12032)
# end
#
# def test_find_all_by_merchant_id_works_for_one_entry
#   list_one = @invoice_r.find_all_by_merchant_id(7)
#   list_two = @invoice_r.find_all_by_merchant_id(2)
#
#   assert_equal 1        , list_one.count
#   assert_equal :shipped, list_one.first.status
#   assert_equal 123      , list_one.first.id
#
#   assert_equal 1        , list_two.count
#   assert_equal :pending, list_two.first.status
#   assert_equal 123      , list_two.first.id
# end
#
# def test_find_all_by_merchant_id_works_for_multiple_entries
#   list = @invoice_r.find_all_by_merchant_id(5)
#
#   assert_equal 2        , list.count
#   assert_equal :shipped, list.first.status
#   assert_equal 1        , list.first.customer_id
#   assert_equal :shipped, list.last.status
#   assert_equal 3        , list.last.customer_id
# end
#
#
#
#
# def test_find_all_by_status_returns_blank_if_none_match
#   assert_equal [], @invoice_r.find_all_by_status(:awesome)
#   assert_equal [], @invoice_r.find_all_by_status(:awesome)
# end
#
# def test_find_all_by_status_works_for_one_entry
#   list_one = @invoice_r.find_all_by_status(:pending)
#
#   assert_equal 1        , list_one.count
#   assert_equal :pending, list_one.first.status
#   assert_equal 123      , list_one.first.id
# end
#
# def test_find_all_by_merchant_id_works_for_multiple_entries
#   list = @invoice_r.find_all_by_status(:shipped)
#
#   assert_equal 3        , list.count
#   assert_equal :shipped , list.first.status
#   assert_equal 1        , list.first.customer_id
#   assert_equal :shipped , list.last.status
#   assert_equal 3        , list.last.customer_id
# end


end
