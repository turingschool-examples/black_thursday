require './test/test_helper'
require './lib/merchant_repository'

# Tests merchant repository
class MerchantRepositoryTest < Minitest::Test
  def setup
    file_name = './data/sample_data/merchants.csv'
    item_1    = mock
    item_2    = mock
    invoice_1 = mock
    invoice_2 = mock
    cust_1    = mock
    cust_2    = mock
    mock_se   = stub(
      find_merchant_items: [item_1, item_2],
      find_merchant_invoices: [invoice_1, invoice_2],
      find_merchant_customers: [cust_1, cust_2]
    )
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
    assert_equal 123_341_05, @merch_repo.all.first.id
    assert_equal 'LolaMarleys', @merch_repo.all.last.name
  end

  def test_find_by_id_method
    assert_nil @merch_repo.find_by_id(8)
    assert_instance_of Merchant, @merch_repo.find_by_id(123_341_05)
    assert_equal 'Shopin1901', @merch_repo.find_by_id(123_341_05).name
  end

  def test_find_by_name
    assert_nil @merch_repo.find_by_name('Satisfaction')
    assert_instance_of Merchant, @merch_repo.find_by_name('LolaMarleys')
    assert_instance_of Merchant, @merch_repo.find_by_name('lolAmarLeYs')
    assert_equal 123_341_15, @merch_repo.find_by_name('lolAmarLeYs').id
  end

  def test_find_all_by_name
    actual = @merch_repo.find_all_by_name('ar')

    assert_equal [], @merch_repo.find_all_by_name('Bullets')
    assert_equal 2, actual.length
    assert_equal 'Candisart', actual.first.name
    assert_equal 'LolaMarleys', actual.last.name
  end

  def test_it_asks_parent_for_items
    assert_equal 2, @merch_repo.items('id').length
    @merch_repo.items('id').each do |item|
      assert_instance_of Mocha::Mock, item
    end
  end

  def test_it_asks_parent_for_invoices
    assert_equal 2, @merch_repo.invoices('id').length
    @merch_repo.invoices('id').each do |invoice|
      assert_instance_of Mocha::Mock, invoice
    end
  end

  def test_it_asks_parent_for_customers
    assert_equal 2, @merch_repo.customers('id').length
    @merch_repo.customers('id').each do |cust|
      assert_instance_of Mocha::Mock, cust
    end
  end

  def test_inspect
    expected = '#<MerchantRepository 4 rows>'
    assert_equal expected, @merch_repo.inspect
  end
end
