require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/customer_repo'

class CustomerRepoTest < Minitest::Test

  def test_it_exist
    cr = CustomerRepo.new("./test/fixtures/customers.csv")
    assert_instance_of CustomerRepo, cr
  end

  def test_it_returns_all_customers_in_an_array
    cr = CustomerRepo.new("./test/fixtures/customers.csv")
    assert_equal "Joey", cr.all.first.first_name
    assert_instance_of Array, cr.all
    assert_equal 8, cr.all.count
    assert_equal "Ondricka", cr.all.first.last_name
  end

  def test_it_can_find_a_customer_by_id
    cr = CustomerRepo.new("./test/fixtures/customers.csv")
    actual = cr.find_by_id(5)
    assert_equal "Sylvester", actual.first_name
    assert_equal 5, actual.id
    assert_instance_of Customer, actual
  end

  def test_it_returns_nil_if_no_id_match_found
    cr = CustomerRepo.new("./test/fixtures/customers.csv")
    actual = cr.find_by_id(28349289034)
    assert_nil actual
  end

  def test_it_can_find_by_customer_by_first_name
    cr = CustomerRepo.new("./test/fixtures/customers.csv")
    customer_1 = cr.find_by_id(5)
    customer_2 = cr.find_by_id(8)
    expected = [customer_1, customer_2]
    assert_equal expected, cr.find_all_by_first_name("Syl")
  end

  def test_it_can_find_by_customer_by_last_name
    cr = CustomerRepo.new("./test/fixtures/customers.csv")
    customer_1 = cr.find_by_id(6)
    customer_2 = cr.find_by_id(7)
    expected = [customer_1, customer_2]
    assert_equal expected, cr.find_all_by_last_name("Dau")
  end

  def test_it_can_create_customer_with_current_highest_number
    cr = CustomerRepo.new("./test/fixtures/customers.csv")

    actual  = cr.create({
      :id          => 1,
      :first_name        => "Pencil",
      :last_name => "You can use it to write things",
      :created_at  => Time.now,
      :updated_at  => Time.now,
                        })

    assert_instance_of Customer, actual
  end

  def test_the_new_customer_id_increments_by_one
    cr = CustomerRepo.new("./test/fixtures/customers.csv")

    actual  = cr.create({
      :id          => 1,
      :first_name        => "Pencil",
      :last_name => "You can use it to write things",
      :created_at  => Time.now,
      :updated_at  => Time.now,
                        })

    assert_equal 9, actual.id
  end

  def test_it_can_update_items_attributes_with_correspending_id
    cr = CustomerRepo.new("./test/fixtures/customers.csv")

    actual = cr.find_by_id(4)
    cr.update(4, {:first_name => "Neo",
                  :last_name => "One",
                  :updated_at => Time.now})
    assert_equal "One", actual.last_name
    assert_equal "Neo", actual.first_name
    assert_instance_of Time, actual.updated_at
  end

  def test_it_can_delete_by_id
    cr = CustomerRepo.new("./test/fixtures/customers.csv")
    cr.delete(1)
    assert_nil cr.find_by_id(1)
  end
end
