require './test/test_helper'
require './lib/customer_repository'
require './lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test
  include SalesEngineTestSetup

  def setup
    super
    @cr = @se.customers
  end


  def test_it_exists
    assert_instance_of CustomerRepository, @cr
  end

  def test_all
    assert_operator 500, :< ,@cr.all.count
  end

  def test_find_by_id
    assert_equal "Casimer", @cr.find_by_id(14).first_name
  end

  def test_find_all_by_first_name
    assert_equal 1, @cr.find_all_by_first_name("Cecelia").length
  end

  def test_find_all_by_last_name
    assert_equal 13, @cr.find_all_by_last_name("om").length
  end




end
