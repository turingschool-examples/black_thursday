require './lib/sales_engine.rb'
require './test_helper.rb'

class CustomerRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
    :items => "./data/mock.csv",
    :merchants => "./data/mock.csv",
    :invoices => "./data/mock.csv",
    :invoice_items => "./data/mock.csv",
    :transactions => "./data/mock.csv",
    :customers => "./data/customers.csv"
    })

    @cr = se.customers
  end

  def test_it_can_return_all_customers
    assert_equal 1000, @cr.all.length
  end

  def test_it_can_find_customer_by_id
    found_customer = @cr.find_by_id(100)
    assert_equal 100, found_customer.id
    assert_instance_of Customer, found_customer
  end

  def test_it_can_find_all_by_first_name
    assert_equal 8, @cr.find_all_by_first_name('oe').length
    assert_instance_of Customer, @cr.find_all_by_first_name('oe').first
  end

  def test_it_can_find_all_by_last_name
    assert_equal 85, @cr.find_all_by_last_name('On').length
    assert_instance_of Customer, @cr.find_all_by_last_name('On').first
  end

  def test_it_can_create_new_customers
    attributes = { :first_name => 'Joan',
                   :last_name => 'Clarke',
                   :created_at => Time.now,
                   :updated_at => Time.now }
    @cr.create(attributes)
    new_customer = @cr.find_by_id(1001)

    assert_equal 'Joan', new_customer.first_name
  end

  def test_it_can_update_customers
    attributes = { :first_name => 'Joan',
                   :last_name => 'Clarke',
                   :created_at => Time.now,
                   :updated_at => Time.now }
    @cr.create(attributes)
    customer = @cr.find_by_id(1001)
    original_time = customer.updated_at
    new_attributes = {:last_name => 'Smith'}
    @cr.update(1001, new_attributes)

    assert_equal 'Smith', customer.last_name
    assert_equal 'Joan', customer.first_name
    assert customer.updated_at > original_time
  end

  def test_it_does_nothing_if_asked_to_update_unknown_customer
    @cr.update(2000, {})
    assert_nil @cr.find_by_id(2000)
  end

  def test_customer_can_be_deleted_by_id
    attributes = { :first_name => 'Joan',
                   :last_name => 'Clarke',
                   :created_at => Time.now,
                   :updated_at => Time.now }
    @cr.create(attributes)
    assert @cr.find_by_id(1001)

    @cr.delete(1001)
    assert_nil @cr.find_by_id(1001)

    assert_nil @cr.delete(2000)
  end

end
