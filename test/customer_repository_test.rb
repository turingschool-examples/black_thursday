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
    assert_equal "Pasquale", @cust_repo.elements[32].first_name
    assert_instance_of Customer, @cust_repo.elements[14]
    assert_equal "Hettinger", @cust_repo.elements[14].last_name

    assert_nil @cust_repo.elements['id']
    assert_nil @cust_repo.elements[999999999]
    assert_nil @cust_repo.elements[0]
    assert_instance_of Time, @cust_repo.elements[34].created_at
    assert_instance_of Time, @cust_repo.elements[9].updated_at
  end

  def test_all_method
    # skip
    @cust_repo.from_csv('./test/fixtures/customers_fixtures.csv')
    all_invoices = @cust_repo.all
    assert_equal 49, all_invoices.count
    assert_instance_of Customer, all_invoices[0]
    assert_instance_of Customer, all_invoices[20]
    assert_instance_of Customer, all_invoices[-1]
    assert_instance_of Array, all_invoices
  end

  def test_find_by_id
    # skip
    @cust_repo.from_csv('./test/fixtures/customers_fixtures.csv')
    customer = @cust_repo.find_by_id(37)
    assert_instance_of Customer, customer
    assert_equal "Maryam", customer.first_name

    invoice2 = @cust_repo.find_by_id(14)
    assert_instance_of Customer, invoice2
    assert_equal "Casimer", invoice2.first_name
    assert_nil @cust_repo.find_by_id(12345678901234567890)
  end

  def test_find_all_by_first_name
    # skip
    @cust_repo.from_csv('./test/fixtures/customers_fixtures.csv')
    invoices = @cust_repo.find_all_by_first_name("Leanne")
    assert_instance_of Array, invoices
    assert_instance_of Customer, invoices[0]
    find = @cust_repo.find_by_id(4)
    assert invoices.include?(find)
    assert_equal 1, invoices.count

    invoices2 = @cust_repo.find_all_by_first_name("Macie")
    assert_instance_of Array, invoices2
    find = @cust_repo.find_by_id(26)
    find2 = @cust_repo.find_by_id(29)
    find3 = @cust_repo.find_by_id(27)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @cust_repo.find_all_by_first_name("gibberish")
    assert_equal [], invoices3
  end

  def test_find_all_by_last_name
    # skip
    @cust_repo.from_csv('./test/fixtures/customers_fixtures.csv')
    invoices = @cust_repo.find_all_by_last_name("Hoppe")
    assert_instance_of Array, invoices
    assert_instance_of Customer, invoices[0]
    find = @cust_repo.find_by_id(16)
    assert invoices.include?(find)
    assert_equal 1, invoices.count

    invoices2 = @cust_repo.find_all_by_last_name("Ward")
    assert_instance_of Array, invoices2
    find = @cust_repo.find_by_id(18)
    find2 = @cust_repo.find_by_id(20)
    find3 = @cust_repo.find_by_id(19)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @cust_repo.find_all_by_last_name("gibberish")
    assert_equal [], invoices3
  end

  def test_find_all_by_invoice_id
    skip
    @cust_repo.from_csv('./test/fixtures/customers_fixtures.csv')
    invoices = @cust_repo.find_all_by_invoice_id(2)
    assert_instance_of Array, invoices
    assert_instance_of Customer, invoices[0]
    find = @cust_repo.find_by_id(12)
    assert invoices.include?(find)
    assert_equal 4, invoices.count

    invoices2 = @cust_repo.find_all_by_invoice_id(8)
    assert_instance_of Array, invoices2
    find = @cust_repo.find_by_id(38)
    find2 = @cust_repo.find_by_id(40)
    find3 = @cust_repo.find_by_id(47)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @cust_repo.find_all_by_invoice_id(9999999999)
    assert_equal [], invoices3
  end

  def test_it_can_create_a_new_invoice
    skip
    assert_equal 0, @cust_repo.all.count
    time = Time.now
    @cust_repo.create(
      item_id:    7,
      invoice_id: 8,
      quantity:   4,
      unit_price: BigDecimal.new(1099),
      created_at: time,
      updated_at: time
    )
    assert_equal 1, @cust_repo.all.count
    assert_equal time, @cust_repo.find_by_id(1).updated_at

    @cust_repo.create(
      item_id:    9,
      invoice_id: 12,
      quantity:   2,
      unit_price: BigDecimal.new(1599),
      created_at: time,
      updated_at: time
    )
    assert_equal 2, @cust_repo.all.count
    assert_equal 12, @cust_repo.find_by_id(2).invoice_id
  end

  def test_it_can_update_an_existing_invoice
    skip
    assert_equal 0, @cust_repo.all.count
    time = Time.now - 1
    @cust_repo.create(
      item_id:    7,
      invoice_id: 8,
      quantity:   4,
      unit_price: BigDecimal.new(1099),
      created_at: @time,
      updated_at: @time
    )
    assert_equal 1, @cust_repo.all.count
    assert_equal 8, @cust_repo.find_by_id(1).invoice_id

    @cust_repo.update(1, {
      item_id:    8,
      invoice_id: 10,
      quantity:   3,
      unit_price: BigDecimal.new(1499),
      created_at: @time,
      updated_at: @time
      })
      assert_equal 1, @cust_repo.all.count
      assert_equal 10, @cust_repo.find_by_id(1).invoice_id
      assert_equal 8, @cust_repo.find_by_id(1).item_id
      assert_equal 3, @cust_repo.find_by_id(1).quantity
      assert time < @cust_repo.find_by_id(1).updated_at
    end

    def test_it_can_delete_an_existing_invoice
      skip
      assert_equal 0, @cust_repo.all.count
      time = Time.now
      @cust_repo.create(
        item_id:    7,
        invoice_id: 8,
        quantity:   4,
        unit_price: BigDecimal.new(1099),
        created_at: time,
        updated_at: time
      )
      assert_equal 1, @cust_repo.all.count
      assert_equal 8, @cust_repo.find_by_id(1).invoice_id

      @cust_repo.delete(1)
      assert_equal 0, @cust_repo.all.count
    end
  end
