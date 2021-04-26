require_relative '../test/test_helper'
require_relative '../lib/customer_repository'
require 'time'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @cr = CustomerRepository.new
    @hash =   {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
              }
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cr
  end

  def test_it_has_no_items_to_start
    assert_equal [], @cr.all
  end

  def test_it_can_create
    @cr.create(@hash)
    assert_instance_of Customer, @cr.all[0]
  end

  def test_it_can_add_by_hash_attributes
    @cr.create(@hash)
    hash2 = {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
              }
    @cr.create(hash2)
    assert_equal 2, @cr.all.length
  end

  def test_it_can_find_all_by_first_name
    @cr.create(@hash)
    hash2 = {
      :id => 6,
      :first_name => "Bob",
      :last_name => "Clarke",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
              }
    @cr.create(hash2)
    assert_equal 1, @cr.find_all_by_first_name("Joan").count

    hash3 = {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
              }
    @cr.create(hash3)
    assert_equal 2, @cr.find_all_by_first_name("Joan").count
  end

  def test_it_can_find_all_by_last_name
    @cr.create(@hash)
    hash2 = {
      :id => 6,
      :first_name => "Bob",
      :last_name => "Smith",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
              }
    @cr.create(hash2)
    assert_equal 1, @cr.find_all_by_first_name("Joan").count

    hash3 = {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
              }
    @cr.create(hash3)
    assert_equal 2, @cr.find_all_by_first_name("Joan").count
  end

end
