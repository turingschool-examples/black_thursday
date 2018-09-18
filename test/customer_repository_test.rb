require_relative './test_helper'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @customer_repo = CustomerRepository.new('./data/customers.csv')
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer_repo
  end

  def test_can_return_all
    assert_equal 1000, @customer_repo.all.count
    assert_equal "Joey", @customer_repo.all.first.first_name
  end

  def test_can_find_customer_by_id
    assert_equal "Ramona", @customer_repo.find_by_id(10).first_name
  end

  def test_can_find_all_customers_by_first_name
    actual = @customer_repo.find_all_by_first_name("oe")
    assert_equal "Joey", actual.first.first_name
    assert_equal 8, actual.count
  end

  def test_can_find_all_customers_by_last_name
    actual = @customer_repo.find_all_by_last_name("On")
    assert_equal "Ondricka", actual.first.last_name
    assert_equal 85, actual.count
  end

  def test_can_create_new_customers
    @customer_repo.create({
      :first_name => "John",
      :last_name => "Smith",
      :created_at => Time.now,
      :updated_at => Time.now
      })

    assert_equal "John", @customer_repo.find_by_id(1001).first_name
  end

  def test_can_update_customer_names_only
    old_times = Time.parse("2012-03-27 14:54:09 UTC")
    updates = {
      :id => 1,
      :first_name => "John",
      :last_name => "Smith",
      :created_at => Time.parse("2030-08-12 14:54:09 UTC"),
      :updated_at => Time.parse("2030-08-12 14:54:09 UTC")
      }
    @customer_repo.update(1, updates)

    assert_equal 1, @customer_repo.find_by_id(1).id
    assert_equal "John", @customer_repo.find_by_id(1).first_name
    assert_equal "Smith", @customer_repo.find_by_id(1).last_name
    assert_equal old_times, @customer_repo.find_by_id(1).created_at
    assert_equal Time.now.to_s, @customer_repo.find_by_id(1).updated_at.to_s
    assert_equal "John Smith", @customer_repo.find_by_id(1).whole_name
  end

  def test_can_delete_customer
    @customer_repo.delete(1)
    assert_nil @customer_repo.find_by_id(1)
    assert_equal 999, @customer_repo.all.length
    assert_equal "Cecelia", @customer_repo.all.first.first_name
  end

end
