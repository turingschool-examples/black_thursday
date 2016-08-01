require './test/test_helper'
require './lib/customer_repo'
class CustomerRepoTest < Minitest::Test
  def test_can_add_customers
    customer_details = {
      :id => 1,
      :first_name => "Ghengis",
      :last_name => "Khan",
      :created_at => Time.now,
      :updated_at => Time.now
      }
    cr = CustomerRepo.new
    cr.add_customer(customer_details)
    cr.add_customer(customer_details)
    assert_equal 2, cr.all.count
    assert_equal "Ghengis", cr.all.first.first_name
  end

  def test_find_by_id
    customer_details = {
      :id => 1,
      :first_name => "Ghengis",
      :last_name => "Khan"
      }
    customer_details_2 = {
      :id => 2,
      :first_name => "Mongke",
      :last_name => "Khan"
      }
    cr = CustomerRepo.new
    cr.add_customer(customer_details)
    cr.add_customer(customer_details_2)
    found_customer = cr.find_by_id(1)
    assert_equal "Ghengis", found_customer.first_name
    assert_equal nil, cr.find_by_id(66)
  end

  def test_find_all_by_first_name
    customer_details = {
      :id => 1,
      :first_name => "Ghengis",
      :last_name => "Khan"
      }
    customer_details_2 = {
      :id => 2,
      :first_name => "Mongke",
      :last_name => "Khan"
      }
    cr = CustomerRepo.new
    cr.add_customer(customer_details)
    cr.add_customer(customer_details_2)
    found_customers = cr.find_all_by_first_name("Ghengis")
    exepected_answer = [cr.find_by_id(1)]
    assert_equal exepected_answer, found_customers
    assert_equal [], cr.find_all_by_first_name("Donald")

  end

  def test_find_all_by_last_name
    customer_details = {
      :id => 1,
      :first_name => "Ghengis",
      :last_name => "Khan"
      }
    customer_details_2 = {
      :id => 2,
      :first_name => "Mongke",
      :last_name => "Khan"
      }
    customer_details_3 = {
      :id => 3,
      :first_name => "Steve",
      :last_name => "Holt!"
    }
    cr = CustomerRepo.new
    cr.add_customer(customer_details)
    cr.add_customer(customer_details_2)
    found_customers = cr.find_all_by_last_name("Khan")
    assert_equal 2, found_customers.count
    assert_equal [], cr.find_all_by_last_name("Trump")
  end

  def test_passing_methods_to_sales_engine
    mock_se = Minitest::Mock.new
    cr = CustomerRepo.new(mock_se)
    mock_se.expect(:find_invoices_by_customer_id, ["invoice"], [1] )
    assert_equal ["invoice"], cr.find_invoices_by_customer_id(1)
    mock_se.expect(:find_merchant_by_merchant_id, "merchant", [14] )
    assert_equal "merchant", cr.find_merchant_by_merchant_id(14)
    assert mock_se.verify
  end
end
