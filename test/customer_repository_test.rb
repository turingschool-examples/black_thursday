require_relative 'test_helper'
require './lib/customer_repository'

class TestCustomerRepository < Minitest::Test

  def setup
    @loaded_file = [{id: 1, first_name: 'Bill', last_name: 'TTith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 2, first_name: 'Jill', last_name: 'Tmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 3, first_name: 'Nill', last_name: 'Emith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 4, first_name: 'Gill', last_name: 'Vmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 5, first_name: 'Pill', last_name: 'Emith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 6, first_name: 'Till', last_name: 'Mmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 7, first_name: 'Grill', last_name: 'Emith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 8, first_name: 'Rill', last_name: 'Lmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 9, first_name: 'Lill', last_name: 'Emith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 10, first_name: 'Will', last_name: 'Kmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 11, first_name: 'Cill', last_name: 'Bmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 12, first_name: 'Will', last_name: 'Cmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 13, first_name: 'Will', last_name: 'Dmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 14, first_name: 'Zill', last_name: 'Emith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 15, first_name: 'Xill', last_name: 'Fmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 16, first_name: 'Mill', last_name: 'Gmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 17, first_name: 'Iill', last_name: 'Hmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 18, first_name: 'Yill', last_name: 'Imith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 19, first_name: 'Dill', last_name: 'Jmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 20, first_name: 'Eill', last_name: 'Kmith', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'}]
    @cr = CustomerRepository.new(@loaded_file)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cr
  end

  def test_it_returns_all_customers
    assert_equal 20, @cr.all.length
    assert_equal Customer, @cr.all.first.class
  end

  def test_it_finds_all_customers_by_id
    customer = @cr.find_by_id(20)

    assert_equal 20, customer.id
    assert_instance_of Customer, customer
  end

  def test_it_finds_all_customers_by_first_name_fragments
    fragment = "Wi"
    customers = @cr.find_all_by_first_name(fragment)

    assert_equal 3, customers.length
    assert_instance_of Customer, customers.first
  end

  def test_it_finds_all_customers_by_last_name_fragments
    fragment = "Em"
    customers = @cr.find_all_by_last_name(fragment)

    assert_equal 5, customers.length
    assert_instance_of Customer, customers.first
  end

  def test_it_creates_new_customer_instance
    attributes = {
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @cr.create(attributes)
    customer = @cr.find_by_id(21)
    assert_equal "Joan", customer.first_name
  end

  def test_it_updates_a_customer
    original_time = @cr.find_by_id(1).updated_at
    attributes = {
      last_name: "Smith"
    }
    @cr.update(1, attributes)
    customer = @cr.find_by_id(1)
    assert_equal "Smith", customer.last_name
    assert_equal "Bill", customer.first_name
    assert customer.updated_at > original_time
    original_time = @cr.find_by_id(12).updated_at

    @cr.update(12, {})
    assert original_time == @cr.find_by_id(12).updated_at
  end

  def test_it_deletes_customer
    @cr.delete(10)
    assert_nil @cr.find_by_id(10)
  end
end
