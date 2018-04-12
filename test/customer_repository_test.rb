require_relative 'test_helper'
require_relative '../lib/customer_repository'

# Test CustomerRepository
class CustomerRepositoryTest < Minitest::Test
  def setup
    @cust_repo = CustomerRepository.new
  end

  def test_it_exists
    @cust_repo = CustomerRepository.new
    assert_instance_of CustomerRepository, @cust_repo
  end

  def test_it_can_create_customers_from_csv
    @cust_repo.from_csv('./test/fixtures/customers_fixtures.csv')
    assert_equal 49, @cust_repo.elements.count
    assert_instance_of Customer, @cust_repo.elements[32]
    assert_equal 'Pasquale', @cust_repo.elements[32].first_name
    assert_instance_of Customer, @cust_repo.elements[14]
    assert_equal 'Hettinger', @cust_repo.elements[14].last_name

    assert_nil @cust_repo.elements['id']
    assert_nil @cust_repo.elements[999999999]
    assert_nil @cust_repo.elements[0]
    assert_instance_of Time, @cust_repo.elements[34].created_at
    assert_instance_of Time, @cust_repo.elements[9].updated_at
  end

  def test_all_method
    @cust_repo.from_csv('./test/fixtures/customers_fixtures.csv')
    all_invoices = @cust_repo.all
    assert_equal 49, all_invoices.count
    assert_instance_of Customer, all_invoices[0]
    assert_instance_of Customer, all_invoices[20]
    assert_instance_of Customer, all_invoices[-1]
    assert_instance_of Array, all_invoices
  end

  def test_find_by_id
    @cust_repo.from_csv('./test/fixtures/customers_fixtures.csv')
    customer = @cust_repo.find_by_id(37)
    assert_instance_of Customer, customer
    assert_equal 'Maryam', customer.first_name

    invoice2 = @cust_repo.find_by_id(14)
    assert_instance_of Customer, invoice2
    assert_equal 'Casimer', invoice2.first_name
    assert_nil @cust_repo.find_by_id(12345678901234567890)
  end

  def test_find_all_by_first_name
    @cust_repo.from_csv('./test/fixtures/customers_fixtures.csv')
    invoices = @cust_repo.find_all_by_first_name('Leanne')
    assert_instance_of Array, invoices
    assert_instance_of Customer, invoices[0]
    find = @cust_repo.find_by_id(4)
    assert invoices.include?(find)
    assert_equal 1, invoices.count

    invoices2 = @cust_repo.find_all_by_first_name('Macie')
    assert_instance_of Array, invoices2
    find = @cust_repo.find_by_id(26)
    find2 = @cust_repo.find_by_id(29)
    find3 = @cust_repo.find_by_id(27)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @cust_repo.find_all_by_first_name('gibberish')
    assert_equal [], invoices3
  end

  def test_find_all_by_last_name
    @cust_repo.from_csv('./test/fixtures/customers_fixtures.csv')
    invoices = @cust_repo.find_all_by_last_name('Hoppe')
    assert_instance_of Array, invoices
    assert_instance_of Customer, invoices[0]
    find = @cust_repo.find_by_id(16)
    assert invoices.include?(find)
    assert_equal 1, invoices.count

    invoices2 = @cust_repo.find_all_by_last_name('Ward')
    assert_instance_of Array, invoices2
    find = @cust_repo.find_by_id(18)
    find2 = @cust_repo.find_by_id(20)
    find3 = @cust_repo.find_by_id(19)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @cust_repo.find_all_by_last_name('gibberish')
    assert_equal [], invoices3
  end

  def test_it_can_create_a_new_customer
    assert_equal 0, @cust_repo.all.count
    time = Time.now
    @cust_repo.create(
      first_name:   'Joan',
      last_name:    'Clarke',
      created_at:   time,
      updated_at:   time
    )
    assert_equal 1, @cust_repo.all.count
    assert_equal time, @cust_repo.find_by_id(1).updated_at

    @cust_repo.create(
      first_name:   'Bob',
      last_name:    'Ross',
      created_at:   time,
      updated_at:   time
    )
    assert_equal 2, @cust_repo.all.count
    assert_equal 'Bob', @cust_repo.find_by_id(2).first_name
  end

  def test_it_can_update_an_existing_invoice
    assert_equal 0, @cust_repo.all.count
    time = Time.now - 1
    @cust_repo.create(
      first_name:   'Joan',
      last_name:    'Clarke',
      created_at:   time,
      updated_at:   time
    )
    assert_equal 1, @cust_repo.all.count
    assert_equal 'Joan', @cust_repo.find_by_id(1).first_name

    @cust_repo.update(1, {
      first_name:   'Bob',
      last_name:    'Ross',
      created_at:   time,
      updated_at:   time
      })
      assert_equal 1, @cust_repo.all.count
      assert_equal 'Bob', @cust_repo.find_by_id(1).first_name
      assert_equal 'Ross', @cust_repo.find_by_id(1).last_name
      assert time < @cust_repo.find_by_id(1).updated_at
  end

  def test_it_can_delete_an_existing_invoice
    assert_equal 0, @cust_repo.all.count
    time = Time.now
    @cust_repo.create(
      first_name:   'Joan',
      last_name:    'Clarke',
      created_at:   time,
      updated_at:   time
    )
    assert_equal 1, @cust_repo.all.count
    assert_equal 'Joan', @cust_repo.find_by_id(1).first_name

    @cust_repo.delete(1)
    assert_equal 0, @cust_repo.all.count
  end
end
