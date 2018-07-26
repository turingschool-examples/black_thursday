require './test/test_helper'
require './lib/customer_repository'
require './lib/file_loader'

class CustomerRespositoryTest < Minitest::Test

  def setup
    @mock_data = [
      {:id => 1,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now},
      {:id => 2,
      :first_name => "Jimmy",
      :last_name => "John",
      :created_at => Time.now,
      :updated_at => Time.now},
      {:id => 3,
      :first_name => "Jessica",
      :last_name => "Jones",
      :created_at => Time.now,
      :updated_at => Time.now},
      {:id => 4,
      :first_name => "James Earl",
      :last_name => "Jones",
      :created_at => Time.now,
      :updated_at => Time.now}
      ]

    @customer_repo = CustomerRespository.new(@mock_data)
  end

  def test_it_exists
    assert_instance_of CustomerRespository, @customer_repo
  end

  def test_it_can_find_all_customers
    assert_equal 4, @customer_repo.all.count
  end

  def test_it_can_find_a_customer_by_id
    assert_equal @customer_repo.all[-1], @customer_repo.find_by_id(4)
    assert_equal @customer_repo.all[0], @customer_repo.find_by_id(1)
  end

  def test_it_can_find_customers_by_first_name
    expected = [@customer_repo.all[-1]]
    actual = @customer_repo.find_all_by_first_name("James Earl")
    assert_equal expected, actual
  end

  def test_it_can_find_customers_by_last_name
    expected = [@customer_repo.all[2], @customer_repo.all[3]]
    actual = @customer_repo.find_all_by_last_name("Jones")
    assert_equal expected, actual
  end

  def test_it_can_create_a_new_customer
    @customer_repo.create({
      :first_name => "Jane",
      :last_name => "Smith",
      :created_at => Time.now,
      :updated_at => Time.now
      })

    assert_equal 5, @customer_repo.all[-1].id
    assert_equal "Jane", @customer_repo.all[-1].first_name
    assert_equal "Smith", @customer_repo.all[-1].last_name
  end

  def test_it_can_update_customer_attributes
    @customer_repo.update(2, {:first_name => "James", :last_name => "Joyce"})

    assert_equal "James", @customer_repo.all[1].first_name
    assert_equal "Joyce", @customer_repo.all[1].last_name
  end

  def test_it_can_update_one_customer_attribute
    @customer_repo.update(2, :last_name => "Dean")

    assert_equal "Jimmy", @customer_repo.all[1].first_name
    assert_equal "Dean", @customer_repo.all[1].last_name
  end

  def test_it_can_delete_a_transaction
    @customer_repo.delete(4)

    assert_equal 3, @customer_repo.all.count
    assert_equal 3, @customer_repo.all[-1].id
  end

end
