require './test/test_helper'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :repo

  def setup
    customer_csv = './test/fixtures/customers.csv'
    parent = SalesEngine.new
    @repo = CustomerRepository.new(customer_csv, parent)
  end

  def test_it_exists
    assert repo
  end

  def test_all
    assert_equal 1000, repo.all.length
  end

  def test_find_by_id
    assert_equal Customer, repo.find_by_id(4).class
    assert_nil repo.find_by_id(0)
  end

  def test_finds_all_first_name
    assert_equal 2, repo.find_all_by_first_name('Magnus').length
    assert_equal 6, repo.find_all_by_first_name('Mag').length
    assert_equal [], repo.find_all_by_first_name("magnushershawn")
  end

  def test_finds_all_last_name
    assert_equal 3, repo.find_all_by_last_name('Reynolds').length
    assert_equal 3, repo.find_all_by_last_name('Rey').length
    assert_equal [], repo.find_all_by_first_name("magnushershawn")
  end

end
