require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :se, :customers, :customer_repo
  def setup
    @se = SalesEngine.from_csv({
      :customers => "./data/small_customers.csv" })
    @customer_repo = CustomerRepository.new(nil, se)
    @customer_repo.add_new({:id => 1, :first_name => "Kerry", :last_name => "Sheldon", :created_at => "2012-03-27 14:56:08 UTC", :updated_at => "2012-03-28 14:56:08 UTC"}, @se)
    @customer_repo.add_new({:id => 2, :first_name => "Colin", :last_name => "Osborn",  :created_at => "2012-03-26 14:56:08 UTC", :updated_at => "2012-03-27 14:56:08 UTC"}, @se)
    @customer_repo.add_new({:id => 3, :first_name => "Fernando", :last_name => "Alonso", :created_at => "2012-03-25 14:56:08 UTC", :updated_at => "2012-03-25 14:56:08 UTC"}, @se)
  end

  def test_we_can_return_all_known_customers
    assert_equal 3, customer_repo.all.length
    assert customer_repo.all.is_a?(Array)
    assert customer_repo.all[0].is_a?(Customer)
  end

  def test_can_find_customer_by_id
    assert customer_repo.find_by_id(1).is_a?(Customer)
  end

  def test_can_find_all_customers_by_first_name
    assert customer_repo.find_all_by_first_name("Kerry").is_a?(Array)
    assert customer_repo.find_all_by_first_name("Colin")[0].is_a?(Customer)
  end

  def test_can_find_all_customers_by_last_name
    assert customer_repo.find_all_by_last_name("Sheldon").is_a?(Array)
    assert customer_repo.find_all_by_last_name("Osborn")[0].is_a?(Customer)
  end
end
