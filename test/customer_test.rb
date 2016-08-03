require "./test/test_helper"
require "./lib/customer"

class CustomerTest < Minitest::Test

  def setup
    @hash = {:id => 2,
             :first_name => "Ben",
             :last_name => "Pepper",
             :created_at => "2012-03-27 14:54:09 UTC",
             :updated_at => "2012-03-27 14:54:09 UTC"}
  end

  def test_it_can_find_an_id
    assert_equal 2, Customer.new(@hash).id
  end

  def test_it_can_find_the_first_name
    assert_equal "Ben", Customer.new(@hash).first_name
  end

  def test_it_can_find_the_last_name
    assert_equal "Pepper", Customer.new(@hash).last_name
  end

  def test_it_can_find_the_created_date
    time = Time.strptime("2012-03-27 14:54:09 UTC", "%Y-%m-%d %H:%M:%S %z")
    assert_equal time, Customer.new(@hash).created_at
  end

  def test_it_can_find_the_updated_date
    time = Time.strptime("2012-03-27 14:54:09 UTC", "%Y-%m-%d %H:%M:%S %z")
    assert_equal time, Customer.new(@hash).updated_at
  end

end
