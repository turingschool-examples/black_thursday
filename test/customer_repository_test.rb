require './test/test_helper'
require './lib/customer_repository'


class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    cr = CustomerRepository.new("./data/customers.csv")
    assert_instance_of CustomerRepository, cr
  end

  def test_it_has_items
    cr = CustomerRepository.new("./data/customers.csv")
    assert_equal 1000, cr.all.count

    assert_equal 1, cr.all.first.id
  end

  def test_it_can_find_item_by_id
    cr = CustomerRepository.new("./data/customers.csv")

    actual = cr.find_by_id(1)

    assert_instance_of Customer, actual
    assert_equal 1, actual.id
  end

  def test_returns_nil_when_no_match_is_found
    cr = CustomerRepository.new("./data/customers.csv")

    actual = cr.find_by_id(99999)

    assert_nil actual
  end

  def test_it_can_find_all_by_first_name
    cr = CustomerRepository.new("./data/customers.csv")
    expected = [cr.all[0]]

    assert_equal expected, cr.find_all_by_first_name("Joey")
    assert_equal 3, cr.find_all_by_first_name("Anya").count
    assert_equal [], cr.find_all_by_first_name("NotName")
  end

  def test_it_can_find_all_by_last_name
    cr = CustomerRepository.new("./data/customers.csv")
    expected = cr.all[0]

    assert_equal expected, cr.find_all_by_last_name("Ondricka").first
    assert_equal 3, cr.find_all_by_last_name("Ondricka").count
    assert_equal [], cr.find_all_by_last_name("NotName")
  end

  def test_it_can_create_new_invoice_items
    cr = CustomerRepository.new("./data/customers.csv")

    new_customer = cr.create(first_name: "Billy", last_name: "Bob", created_at: Time.now, updated_at: Time.now)

    assert_instance_of Customer, new_customer

    actual = [cr.all.last]

    assert_equal cr.find_all_by_first_name("Billy"), actual
    assert_equal cr.find_all_by_last_name("Bob"), actual
  end

  def test_item_attributes_can_be_updated
    cr = CustomerRepository.new("./data/customers.csv")

    actual = cr.find_by_id(1)

    assert_equal "Joey", actual.first_name

    id = (1)
    attributes = {first_name: "Blah",
                  last_name: "deBlah"}

    cr.update(id, attributes)

    assert_equal "Blah", cr.find_by_id(id).first_name
    assert_equal "deBlah", cr.find_by_id(id).last_name
  end

  def test_repo_can_delete_items
    cr = CustomerRepository.new("./data/customers.csv")

    cr.delete(1)

    assert_nil cr.find_by_id(1)
  end

end
