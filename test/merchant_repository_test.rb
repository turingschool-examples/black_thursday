require './test/test_helper'
require './lib/merchant_repository'
require './test/fixtures/mock_sales_engine'

# Tests merchant repository
class MerchantRepositoryTest < Minitest::Test
  def setup
    file_name = './data/sample_data/merchants.csv'
    mock_se = MockSalesEngine.new
    @merch_repo = MerchantRepository.new(file_name, mock_se)
  end

  def test_merchant_repository_class_exists
    assert_instance_of MerchantRepository, @merch_repo
  end

  def test_merchant_repository_adds_self_to_merchant
    assert_equal @merch_repo, @merch_repo.all.first.parent
  end

  def test_all_method
    assert_instance_of Array, @merch_repo.all
    assert_instance_of Merchant, @merch_repo.all.first
    assert_equal 12334105, @merch_repo.all.first.id
    assert_equal 'LolaMarleys', @merch_repo.all.last.name
  end

  def test_find_by_id_method
    assert_nil @merch_repo.find_by_id('8')
    assert_instance_of Merchant, @merch_repo.find_by_id(12334105)
    assert_equal 'Shopin1901', @merch_repo.find_by_id(12334105).name
  end

  def test_find_by_name
    assert_nil @merch_repo.find_by_name('Satisfaction')
    assert_instance_of Merchant, @merch_repo.find_by_name('LolaMarleys')
    assert_instance_of Merchant, @merch_repo.find_by_name('lolAmarLeYs')
    assert_equal 12334115, @merch_repo.find_by_name('lolAmarLeYs').id
  end

  def test_find_all_by_name
    actual = @merch_repo.find_all_by_name('ar')

    assert_equal [], @merch_repo.find_all_by_name('Bullets')
    assert_equal 2, actual.length
    assert_equal 'Candisart', actual.first.name
    assert_equal 'LolaMarleys', actual.last.name
  end

  def test_it_asks_parent_for_items
    assert_equal 2, @merch_repo.items('1234').length
    @merch_repo.items('1234').each do |item|
      assert_instance_of MockItem, item
    end
  end

  def test_inspect
    assert_equal @merch_repo, @merch_repo.inspect
    refute @merch_repo.inspect.to_s.length > 50
  end
end
