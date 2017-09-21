require './test/test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

attr_reader :customer_repo
 def setup
   @customer_repo = Fixture.repo(:customers)
 end

 def test_that_an_instance_exists
   assert_instance_of CustomerRepository, customer_repo
 end

 def test_all_returns_an_array_of_all_customer_instances
   assert_instance_of Array, customer_repo.all
   assert_instance_of Customer, customer_repo.all.first
 end

 def test_find_by_id_returns_nil_if_no_matching_id
   assert_nil customer_repo.find_by_id(-01)
 end

 def test_find_by_id_returns_customer_instance
   customer = customer_repo.find_by_id(14)
   assert_instance_of Customer, customer

   assert_equal 14, customer.id
 end

 def test_find_all_by_first_name_returns_an_empty_array_with_no_match
   assert_equal [], customer_repo.find_all_by_first_name('!@#12345678$%^&}')
 end

 def test_find_all_by_invoice_id_returns_all_that_match_the_id
   assert_equal 1, customer_repo.find_all_by_first_name("Sallie").count
 end

 def test_find_all_by_last_name_returns_an_empty_array_with_no_match
   assert_equal [], customer_repo.find_all_by_last_name('123456789!@#$%^&*')
 end

 def test_find_all_by_last_name_returns_all_that_match_the_id
   assert_equal 1, customer_repo.find_all_by_last_name("Stark").count
 end

 def test_find_all_by_last_name_returns_all_that_it_is_case_insensitive
   assert_equal 1, customer_repo.find_all_by_last_name("STaRk").count
 end

 def test_find_all_by_first_name_returns_an_array_of_customers_with_substring
   matches = customer_repo.find_all_by_first_name('mar')
   expected = ["Marcia", "Margie", "Margret", "Marianne", "Marvin"]
   assert_equal expected, matches.map(&:first_name).sort
 end
end
