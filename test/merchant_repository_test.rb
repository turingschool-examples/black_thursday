require_relative 'test_helper'
require 'csv'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_opens_csv_into_array
    merchant = MerchantRepository.new
    actual   = merchant.all_merchant_data.class
    expected = Array

    assert_equal expected, actual
  end

  def test_it_returns_merchant_instances
    merchant = MerchantRepository.new
    actual   = merchant.all[0].inspect
    expected = '#<CSV::Row id:"12334105" name:"Shopin1901" created_at:"2010-12-10" updated_at:"2011-12-04">'

    assert_equal expected, actual
  end

  def test_it_can_return_ids
    merchant = MerchantRepository.new
    actual   = merchant.find_by_id[0][:id]
    expected = "12334105"

    assert_equal expected, actual
  end


end
