require_relative '../lib/customer_repository'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class CustomerRepositoryTest < Minitest::Test
  attr_reader :repo

  def test_class_exist
    assert CustomerRepository
  end

  def setup
    @repo = CustomerRepository.new([{:id=> 1, :first_name=>"Joey", :last_name=>"Ondricka", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"},
             {:id=> 2, :first_name=>"Cecelia", :last_name=>"Osinski", :created_at=>"2012-03-27 14:54:10 UTC", :updated_at=>"2012-03-27 14:54:10 UTC"},
             {:id=> 3, :first_name=>"Mariah", :last_name=>"Toy", :created_at=>"2012-03-27 14:54:10 UTC", :updated_at=>"2012-03-27 14:54:10 UTC"},
             {:id=> 4, :first_name=>"Leanne", :last_name=>"Braun", :created_at=>"2012-03-27 14:54:10 UTC", :updated_at=>"2012-03-27 14:54:10 UTC"},
             {:id=> 5, :first_name=>"Sylvester", :last_name=>"Nader", :created_at=>"2012-03-27 14:54:10 UTC", :updated_at=>"2012-03-27 14:54:10 UTC"},
             {:id=> 6, :first_name=>"Heber", :last_name=>"Kuhn", :created_at=>"2012-03-27 14:54:10 UTC", :updated_at=>"2012-03-27 14:54:10 UTC"},
             {:id=> 7, :first_name=>"Parker", :last_name=>"Daugherty", :created_at=>"2012-03-27 14:54:10 UTC", :updated_at=>"2012-03-27 14:54:10 UTC"},
             {:id=> 8, :first_name=>"Loyal", :last_name=>"Considine", :created_at=>"2012-03-27 14:54:11 UTC", :updated_at=>"2012-03-27 14:54:11 UTC"},
             {:id=> 9, :first_name=>"Dejon", :last_name=>"Fadel", :created_at=>"2012-03-27 14:54:11 UTC", :updated_at=>"2012-03-27 14:54:11 UTC"},
             {:id=> 10, :first_name=>"Ramona", :last_name=>"Reynolds", :created_at=>"2012-03-27 14:54:11 UTC", :updated_at=>"2012-03-27 14:54:11 UTC"}])
  end

  def test_all_method_is_an_array
    assert_equal Array, repo.all.class
  end

  def test_that_find_by_id_works
    assert_equal "Ramona", repo.find_by_id("10").first_name
    assert_equal Customer, repo.find_by_id("10").class
  end

  def test_that_find_by_id_returns_nil_when_no_matches_found
    assert_equal nil, repo.find_by_id(00000)
  end

  def test_that_find_all_by_first_name_works
    assert_equal [3], repo.find_all_by_first_name("Mariah").map(&:id)
  end

  def test_that_find_all_by_first_name_returns_empty_array_when_no_matches_found
    assert_equal [], repo.find_all_by_first_name("Alex")
  end

  def test_that_find_all_by_last_name_works
    assert_equal [6], repo.find_all_by_last_name("kuhn").map(&:id)
  end

  def test_that_find_all_by_last_name_returns_empty_array_when_no_matches_found
    assert_equal [], repo.find_all_by_last_name("navarrete")
  end


end
