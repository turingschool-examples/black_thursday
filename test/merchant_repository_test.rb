require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merch = MerchantRepository.new
  end

  def test_it_exists
    @merch = MerchantRepository.new
    assert_instance_of MerchantRepository, @merch
  end

  def test_it_can_create_merchants_from_csv
    @merch.from_csv('./data/merchants.csv')
    # ('./test/fixtures/merchant_fixtures.csv')
    assert_equal 475, @merch.elements.count
    assert_instance_of Merchant, @merch.elements[12334115]
    assert_equal 'LolaMarleys', @merch.elements[12334115].name
    assert_instance_of Merchant, @merch.elements[12334189]
    assert_equal 'JacquieMann', @merch.elements[12334189].name

    assert_nil @merch.elements['id']
    assert_nil @merch.elements[999999999]
    assert_nil @merch.elements[0]
  end

  def test_all_method
    @merch.from_csv('./data/merchants.csv')
    all_merchants = @merch.all
    assert_equal 475, all_merchants.count
    assert_instance_of Merchant, all_merchants[0]
    assert_instance_of Merchant, all_merchants[400]
    assert_instance_of Merchant, all_merchants[-1]
    assert_instance_of Array, all_merchants
  end

  def test_find_by_id
    @merch.from_csv('./data/merchants.csv')
    merchant = @merch.find_by_id(12334202)
    assert_instance_of Merchant, merchant
    assert_equal 'VectorCoast', merchant.name

    merchant2 = @merch.find_by_id(12334223)
    assert_instance_of Merchant, merchant2
    assert_equal 'Snewzy', merchant2.name
    assert_nil @merch.find_by_id(12345678901234567890)
  end

  def test_find_by_name_not_case_sensitive
    @merch.from_csv('./data/merchants.csv')
    merchant = @merch.find_by_name('snewzy')
    assert_instance_of Merchant, merchant
    assert_equal 12334223, merchant.id

    merchant2 = @merch.find_by_name('uniford')
    assert_instance_of Merchant, merchant2
    assert_equal 12334174, merchant2.id
    assert_nil @merch.find_by_name('random gibberish')
  end

  def test_find_all_by_name
    @merch.from_csv('./data/merchants.csv')
    merchants = @merch.find_all_by_name('Snewzy')
    assert_instance_of Array, merchants
    find = @merch.find_by_id(12334223)
    assert merchants.include?(find)

    merchants2 = @merch.find_all_by_name('tt')
    assert_instance_of Array, merchants2
    find = @merch.find_by_id(12334301)
    find2 = @merch.find_by_id(12334302)
    find3 = @merch.find_by_id(12334281)
    assert merchants2.include?(find)
    assert merchants2.include?(find2)
    refute merchants2.include?(find3)

    merchants3 = @merch.find_all_by_name('random gibberish')
    assert_equal [], merchants3
  end

  def test_it_can_create_a_new_merchant
    assert_equal 0, @merch.all.count
    @merch.create(:name => 'PenCo')
    assert_equal 1, @merch.all.count
    assert_equal 'PenCo', @merch.find_by_id(1).name

    @merch.create(:name => 'Pens')
    assert_equal 2, @merch.all.count
    assert_equal 'Pens', @merch.find_by_id(2).name
  end

  def test_it_can_update_an_existing_merchant
    assert_equal 0, @merch.all.count
    @merch.create(:name => 'PenCo')
    assert_equal 1, @merch.all.count
    assert_equal 'PenCo', @merch.find_by_id(1).name
    
    @merch.update(1, {:name => 'Pen'})
    assert_equal 1, @merch.all.count
    assert_equal 'Pen', @merch.find_by_id(1).name
  end

  def test_it_can_delete_an_existing_merchant
    assert_equal 0, @merch.all.count
    @merch.create(:name => 'PenCo')
    assert_equal 1, @merch.all.count
    assert_equal 'PenCo', @merch.find_by_id(1).name

    @merch.delete(1)
    assert_equal 0, @merch.all.count
  end
end
