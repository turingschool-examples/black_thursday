require_relative 'test_helper'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    @merchant_repository = @se.merchants
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_merchant_repo_holds_all_instances_of_merchants
    assert_equal 475, @merchant_repository.all.length
  end

  def test_all_returns_array_of_all_merchant_objects
    merchants = @merchant_repository.all
    assert merchants.all? do |merch|
      merch.class == Merchant
    end
  end

  def test_find_by_id_returns_merchants_with_given_id
    refute @merchant_repository.find_by_id('notarealid')
    assert_instance_of Merchant, @merchant_repository.find_by_id(12334105)
    assert_equal 12334105, @merchant_repository.find_by_id(12334105).id
    assert_equal 'Shopin1901', @merchant_repository.find_by_id(12334105).name
  end

  def test_find_by_name_returns_merchant_object_with_given_name
    refute @merchant_repository.find_by_name('notarealname')
    assert_instance_of Merchant, @merchant_repository.find_by_name('Candisart')
    assert_equal 12334112, @merchant_repository.find_by_name('Candisart').id
    assert_equal 'Candisart', @merchant_repository.find_by_name('Candisart').name
  end

  def test_find_all_by_name_fragment
    assert_instance_of Array, @merchant_repository.find_all_by_name('art')
    assert_equal 35, @merchant_repository.find_all_by_name('art').length
    assert_equal 3, @merchant_repository.find_all_by_name('style').length
    assert_equal [], @merchant_repository.find_all_by_name('asdgihweogdv')
  end

  def test_it_can_create_a_new_merchant_object
    refute @merchant_repository.find_by_id(12337412)
    attributes = {
      name: 'Turing School of Software and Design'
    }
    @merchant_repository.create(attributes)
    assert_equal 'Turing School of Software and Design', @merchant_repository.find_by_id(12337412).name
  end

  def test_it_can_update_a_merchants_name
    @merchant_repository.create({name: 'test'})
    assert @merchant_repository.find_by_name('test')
    refute @merchant_repository.find_by_name('new_name')

    @merchant_repository.update(12337412,{name: 'new_name'} )
    refute @merchant_repository.find_by_name('test')
    assert @merchant_repository.find_by_name('new_name')
  end

  def test_it_can_delete_a_merchant_object
    assert @merchant_repository.find_by_id(12337411)
    @merchant_repository.delete(12337411)
    refute @merchant_repository.find_by_id(12337411)
  end
end
