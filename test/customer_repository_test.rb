require './test/test_helper.rb'
require './lib/file_loader.rb'
require './lib/customer_repository.rb'

class CustomerRepositoryTest < Minitest::Test
  include FileLoader

  def setup
    @cr = CustomerRepository.new(load_file('./data/customers.csv'))
    @attributes = {
      first_name: 'Brian',
      last_name: 'Zanti',
      created_at: Time.now,
      updated_at: Time.now
    }
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cr
  end

  def test_it_makes_a_repository_of_customers
    assert_equal 1000, @cr.repository.count
  end

  def test_all_will_return_entire_repository
    assert_equal @cr.repository, @cr.all
  end

  def test_it_can_find_by_id_number
    assert_equal @cr.all[0], @cr.find_by_id(1)
    assert_nil @cr.find_by_id(5000)
  end

  def test_it_can_find_all_by_first_name
    assert_equal [@cr.all[0]], @cr.find_all_by_first_name('Joey')
    assert_equal [], @cr.find_all_by_first_name('Jimothy')
    assert_equal 198, @cr.find_all_by_first_name('T').length
  end

  def test_it_can_find_all_by_last_name
    assert_equal [@cr.all[0], @cr.all[763], @cr.all[969]], @cr.find_all_by_last_name('Ondricka')
    assert_equal [], @cr.find_all_by_last_name('Jimothy')
    assert_equal 265, @cr.find_all_by_last_name('T').length
  end

  def test_it_can_create_customers
    assert_equal Customer, @cr.find_by_id(1000).class
    assert_nil @cr.find_by_id(1001)
    new_customer = @cr.create(@attributes)
    assert @cr.repository.include?(new_customer)
    assert_equal 1001, new_customer.id
  end

  def test_it_can_update_customers
    new_customer = @cr.create(@attributes)
    @cr.update(1001, first_name: 'Brain')
    assert_equal 'Brain', new_customer.first_name
    assert_equal 'Zanti', new_customer.last_name
  end

  def test_it_can_delete_an_entry
    new_customer = @cr.create(@attributes)
    assert @cr.repository.include?(new_customer)
    @cr.delete(1001)
    refute @cr.repository.include?(new_customer)
  end
end
