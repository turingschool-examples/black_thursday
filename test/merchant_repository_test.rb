require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :mr

  def setup
    parent = mock('parent')
    merchants = [{
      :id => "12334141",
      :name => "jejum",
      :created_at => "2007-06-25",
      :updated_at => "2015-09-09"
    },{
      :id => "24537741",
      :name => "ashton john",
      :created_at => "2007-09-10",
      :updated_at => "2015-10-11"
    }]
    @mr = MerchantRepository.new(merchants, parent)
  end

  def test_setup_it_exists
    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_find_all_merchants
    assert_equal 2, mr.all.count
  end

  def test_can_find_merchants_by_id
    assert_equal "12334141", mr.find_by_id("12334141").id
    assert_equal "24537741", mr.find_by_id("24537741").id
  end

  def test_can_find_merchants_by_name
    assert_equal "jejum", mr.find_by_name("jejum").name
    assert_equal "ashton john", mr.find_by_name("ashton john").name
  end

  def test_can_find_all_merchants_by_name
    assert_equal [], mr.find_all_by_name("paul")
    assert_equal 1, mr.find_all_by_name("john").count
  end

  def test_use_find_all_items
    mr.parent.stubs(:find_items_by_merchant_id).with('12345')

    assert_nil mr.find_all_items_by_merchant_id('12345')
  end

end
