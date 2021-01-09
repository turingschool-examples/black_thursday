require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository.rb'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @sample_data = './test/fixtures/sample_merchants.csv'
  end

  def test_it_exists
    mr = MerchantRepository.new(@sample_data, 'engine')

    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_inspect
    mr = MerchantRepository.new(@sample_data, 'engine')

    assert_equal '#<MerchantRepository 4 rows>', mr.inspect
  end

  def test_all
    mr = MerchantRepository.new(@sample_data, 'engine')

    assert_instance_of Array, mr.all
    assert_equal mr.merchants, mr.all
  end

  def test_find_by_id
    mr = MerchantRepository.new(@sample_data, 'engine')

    assert_nil mr.find_by_id(5)
    assert_equal mr.merchants[1], mr.find_by_id(2)
  end

  def test_find_by_name
    mr = MerchantRepository.new(@sample_data, 'engine')

    assert_nil mr.find_by_name('Merchant Number 5')
    assert_equal mr.merchants[0], mr.find_by_name('Merchant Number 1')
  end

  def test_find_all_by_name
    mr = MerchantRepository.new(@sample_data, 'engine')

    assert_equal mr.merchants, mr.find_all_by_name('Merchant')
    assert_equal [mr.merchants[2]], mr.find_all_by_name('Number 3')
  end

  def test_max_merchant_id
    mr = MerchantRepository.new(@sample_data, 'engine')

    assert_equal 4, mr.max_merchant_id
    assert_equal mr.merchants[3], mr.find_by_id(mr.max_merchant_id)
  end

  def test_create_new_merchant
    mr = MerchantRepository.new(@sample_data, 'engine')
    attributes = {name: 'Merchant Number 5'}

    mr.create(attributes)

    assert_equal 'Merchant Number 5', mr.find_by_id(5).name
    assert_equal 5, mr.all.count
  end

  def test_update_with_id_and_attributes
    mr = MerchantRepository.new(@sample_data, 'engine')
    attributes = { name: 'This is now a new name' }
    time = Time.now.round

    mr.update(2, attributes)


    assert_equal 'This is now a new name', mr.merchants[1].name
    assert_equal time, mr.merchants[1].updated_at
  end

  def test_delete_with_id
    mr = MerchantRepository.new(@sample_data, 'engine')
    mr.delete(4)

    expected = [mr.merchants[0], mr.merchants[1], mr.merchants[2]]

    assert_nil mr.find_by_id(4)
    assert_equal expected, mr.all
  end
end
