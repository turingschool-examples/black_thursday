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

end
