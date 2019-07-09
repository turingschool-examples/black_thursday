require_relative 'test_helper'
require_relative '../lib/customer_repo'

class CustomerRepoTest < Minitest::Test
  
  def setup 
    customer_array = [{:id=>"1", :first_name=>"Joan", :last_name=>"Ondricka", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}, 
    {:id=>"2", :first_name=>"Joey", :last_name=>"Ondricka", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}, 
    {:id=>"3", :first_name=>"Joey", :last_name=>"Hola", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}, 
    {:id=>"4", :first_name=>"Joel", :last_name=>"Hola", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}, 
    {:id=>"5", :first_name=>"Joel", :last_name=>"Funny", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}, 
    {:id=>"6", :first_name=>"Harry", :last_name=>"Clark", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}, 
    {:id=>"7", :first_name=>"Marry", :last_name=>"House", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}]
    @customer_repo = CustomerRepo.new(customer_array)
  end
  
  def test_it_exists
    assert_instance_of CustomerRepo, @customer_repo
  end
  
  def test_it_returns_all_customers
    assert_equal @customer_repo.customers, @customer_repo.all
  end
  
  def test_it_finds_customer_by_id
    assert_equal @customer_repo.customers[0], @customer_repo.find_by_id(1)
    assert_equal nil, @customer_repo.find_by_id(123456)
  end
  
  def test_it_finds_all_customers_by_first_name
    assert_equal [@customer_repo.customers[1], @customer_repo.customers[2]], @customer_repo.find_all_by_first_name("Joey")
    assert_equal [], @customer_repo.find_all_by_first_name("Noname")
  end
  
  def test_it_finds_all_customers_by_last_name
    assert_equal [@customer_repo.customers[2], @customer_repo.customers[3]], @customer_repo.find_all_by_last_name("Hola")
    assert_equal [], @customer_repo.find_all_by_last_name("Noname")
  end
  
  def test_it_creates_customer_with_attributes
    refute_instance_of Customer, @customer_repo.customers[7]
  
    @customer_repo.create({:id => 8,
                           :first_name => "Joan",
                           :last_name  => "Demango",
                           :created_at => Time.now,
                           :updated_at => Time.now
                          })
  
    assert_instance_of Customer, @customer_repo.customers[7]
  end
  
  def test_it_updates_customer_attributes
    refute_equal "Joan", @customer_repo.customers[6].first_name
    refute_equal "Demango", @customer_repo.customers[6].last_name
  
    current_time = Time.now.to_s
  
    @customer_repo.update(7, {:id => 8,
                              :first_name => "Joan",
                              :last_name  => "Demango",
                              :created_at => Time.now,
                              :updated_at => current_time
                             })
  
    assert_equal "Joan", @customer_repo.customers[6].first_name
    assert_equal "Demango", @customer_repo.customers[6].last_name
    assert_equal current_time, @customer_repo.customers[6].updated_at.to_s
  end
  
  def test_it_deletes_customer_by_id
    assert_instance_of Customer, @customer_repo.find_by_id(1)
    @customer_repo.delete(1)
    assert_equal nil, @customer_repo.find_by_id(1)
  end


end
