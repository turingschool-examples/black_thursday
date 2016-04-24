require_relative 'test_helper'
require_relative '../lib/merchant_analytics'
require_relative '../lib/sales_engine'

class MerchantAnalyticsTest < Minitest::Test

  attr_reader :se, :ma

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})
    @ma = MerchantAnalytics.new(se)
    @se.merchant_repo = MerchantRepository.new(nil, se)
    @se.item_repo = ItemRepository.new(nil, se)
    @se.invoice_repo = InvoiceRepository.new(nil, se)

    @se.merchant_repo.add_new({:id => 1, :name => "Merch1"}, @se)
    @se.merchant_repo.add_new({:id => 2, :name => "Merch2"}, @se)
    @se.merchant_repo.add_new({:id => 3, :name => "Merch3"}, @se)

    @se.item_repo.add_new({:id => 1, :name => "Item1", :unit_price => 200, :merchant_id => 1}, @se)
    @se.item_repo.add_new({:id => 2, :name => "Item2", :unit_price => 100, :merchant_id => 1}, @se)

    @se.item_repo.add_new({:id => 3, :name => "Item3", :unit_price => 100, :merchant_id => 2}, @se)

    @se.item_repo.add_new({:id => 4, :name => "Item4", :unit_price => 500, :merchant_id => 3}, @se)
    @se.item_repo.add_new({:id => 5, :name => "Item5", :unit_price => 1000, :merchant_id => 3}, @se)
    @se.item_repo.add_new({:id => 6, :name => "Item6", :unit_price => 3000, :merchant_id => 3}, @se)
    @se.item_repo.add_new({:id => 7, :name => "Item7", :unit_price => 1250, :merchant_id => 3}, @se)
    @se.invoice_repo.add_new({:id => 1, :customer_id => 1, :merchant_id => 1, :status => "shipped", :created_at => "2016-04-18"}, @se)
    @se.invoice_repo.add_new({:id => 2, :customer_id => 1, :merchant_id => 1, :status => "pending", :created_at => "2016-04-19"}, @se)
    @se.invoice_repo.add_new({:id => 3, :customer_id => 2, :merchant_id => 2, :status => "returned", :created_at => "2016-04-19"}, @se)
    @se.invoice_repo.add_new({:id => 4, :customer_id => 3, :merchant_id => 3, :status => "shipped", :created_at => "2016-04-20"}, @se)
    @se.invoice_repo.add_new({:id => 5, :customer_id => 1, :merchant_id => 1, :status => "shipped", :created_at => "2016-04-18"}, @se)
    @se.invoice_repo.add_new({:id => 6, :customer_id => 1, :merchant_id => 1, :status => "shipped", :created_at => "2016-04-18"}, @se)
    @se.invoice_repo.add_new({:id => 7, :customer_id => 1, :merchant_id => 1, :status => "shipped", :created_at => "2016-04-18"}, @se)
  end

  def test_it_has_ref_to_se_on_ititialization
    assert_equal true, !ma.sales_engine.nil?
  end

  def test_it_has_access_to_SD_methods
    assert_equal 1.0, ma.standard_deviation([1,2,3])
    assert_equal 2.65, ma.standard_deviation([1,2,6])
  end

  def test_it_has_access_to_SA_methods
      assert_equal 2.33, ma.average_items_per_merchant
  end





end
