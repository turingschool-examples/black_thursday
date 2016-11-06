require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repo
   def setup
    parent        = Minitest::Mock.new
    @customer_repo = CustomerRepository.new('./data/test_customers.csv', parent)
  end

  def test_it_exists
    assert CustomerRepository.new
  end

  def test_it_initializes_with_a_file
    assert CustomerRepository.new('./data/test_customers.csv')
  end

  def test_it_has_custom_inspect
    assert_equal "#<CustomerRepository: 74 rows>", customer_repo.inspect
  end

  # def test_find_all_by_merchant_id_calls_parent
  #   customer_repo.parent.expect(:find_merchant_by_id, nil, [5])
  #   customer_repo.find_merchant_by_id(5)
  #   customer_repo.parent.verify
  # end

  def test_it_turns_file_contents_to_CSV_object
    assert_equal CSV, customer_repo.file_contents.class
  end

  def test_it_generates_array_of_item_objects_from_csv_object
    assert customer_repo.all.all?{|row| row.class == Customer}
  end

  def test_it_calls_id_of_item_object
    assert_equal 1, customer_repo.all[0].id
  end

  def test_it_retrieves_all_item_objects
    assert_equal Customer, customer_repo.all[0].class
    assert_equal 74, customer_repo.all.count
  end

  def test_item_ids_are_uniq
    ids = customer_repo.all {|row| row[:id]}
    assert_equal ids, ids.uniq
  end

  def test_find_invoice_by_id_returns_an_instance_of_invoice
    customers = customer_repo.find_by_id(1)
    assert_equal Customer, customers.class
  end

  def test_it_returns_nil_if_id_not_found
    customers = customer_repo.find_by_id(123)
    assert_equal nil,customers
  end

  def test_it_finds_all_items_by_first_name
    customers  = customer_repo.find_all_by_first_name("Lisa")
    assert_equal 2, customers.count
  end

  def test_it_finds_all_items_by_a_fragment_first_name
    customers  = customer_repo.find_all_by_first_name("as")
    assert_equal 5, customers.count
  end

  def test_it_returns_empty_array_if_no_first_names_are_found
    customers  = customer_repo.find_all_by_first_name("Jason")
    assert_equal [], customers
  end

  def test_it_finds_all_items_by_a_fragment_last_name
    customers  = customer_repo.find_all_by_first_name("Dickens")
    assert_equal 2, customers.count
  end

  def test_it_finds_all_items_by_a_fragment_last_name
    customers  = customer_repo.find_all_by_last_name("ad")
    assert_equal 5, customers.count
  end

  def test_it_returns_empty_array_if_no_last_names_are_found
    customers  = customer_repo.find_all_by_last_name("Schutte")
    assert_equal [], customers
  end

end
