gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine.rb'

class MerchantTest < Minitest::Test

  def test_merchant_exists
    merch = Merchant.new({:name => "Pillowtalkdartmoor",
                          :id => 12337011,
                          :created_at => "2004-10-06",
                          :updated_at => "2014-12-04"},
                          self)
    assert_instance_of Merchant, merch
  end

  def test_merchant_has_name
    merch = Merchant.new({:name => "Pillowtalkdartmoor",
                          :id => 12337011,
                          :created_at => "2004-10-06",
                          :updated_at => "2014-12-04"},
                          self)
    name = merch.name

    assert_equal "Pillowtalkdartmoor", name
  end

  def test_merchant_has_id
    merch = Merchant.new({:name => "Pillowtalkdartmoor",
                          :id => 12337011,
                          :created_at => "2004-10-06",
                          :updated_at => "2014-12-04"},
                          self)
    id = merch.id

    assert_equal 12337011, id
  end

  def test_merchant_has_created_at_date
    merch = Merchant.new({:name => "Pillowtalkdartmoor",
                          :id => 12337011,
                          :created_at => "2004-10-06",
                          :updated_at => "2014-12-04"},
                          self)
    create_date = merch.created_at

    assert_equal "2004-10-06", create_date
  end

  def test_merchant_has_updated_at_date
    merch = Merchant.new({:name => "Pillowtalkdartmoor",
                          :id => 12337011,
                          :created_at => "2004-10-06",
                          :updated_at => "2014-12-04"},
                          self)
    update_date = merch.updated_at

    assert_equal "2014-12-04", update_date
  end

  def test_invoice_can_check_for_parent
    # se = SalesEngine.from_csv({
    #       :items     => "./data/items.csv",
    #       :merchants => "./data/merchants.csv",
    #       :invoices => "./data/invoices.csv"
    #     })
    invoice = se.invoices.find_by_id(71)
    merchant = se.merchants.find_by_id(12336292)

    assert_equal invoice.merchant_id, merchant.id
  end

end
