require './test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.new("")
    @ir = @se.item_repo
    @mr = @se.merchant_repo
    @sa = SalesAnalyst.new(@se)
    item_1 = {
      :id => 1,
      :merchant_id => 1,
      :name => "A tiny piece of cheese",
      :unit_price => 10
    }
    item_2 = {
      :id => 2,
      :merchant_id => 1,
      :name => "A baseball of mozzarella",
      :unit_price => 20
    }
    item_3 = {
      :id => 3,
      :merchant_id => 1,
      :name => "A golfball of gorgonzola",
      :unit_price => 30
    }
    item_4 = {
      :id => 4,
      :merchant_id => 2,
      :name => "A dead bird in a bag",
      :description => "I don't know what I expected",
      :unit_price => 5000
    }
    item_5 = {
      :id => 5,
      :merchant_id => 2,
      :name => "Frozen banana",
      :unit_price => 5
    }
    merchant_1 = {
      :name => "Ghengis' Cheese Shop",
      :id => 1
    }
    merchant_2 = {
      :name => "Bluth Family Store",
      :id => 2
    }
    item_details = [item_1, item_2, item_3, item_4, item_5]
    merchant_details = [merchant_1, merchant_2]
    item_details.each do |item|
      @ir.add(item)
    end
    merchant_details.each do |merchant|
      @mr.add(merchant)
    end
  end

  def test_analyst_can_get_merchant_and_their_items
    expected_items = @mr.all.first.items
    assert_equal expected_items, @sa.sales_engine.find_all_items_by_merchant_id(1)
  end

  def test_average_price_for_merchant
    assert_equal 0.20, @sa.average_item_price_for_merchant(1)
    assert_equal 25.03, @sa.average_item_price_for_merchant(2)
  end

  def test_average_price_per_merchant
    assert_equal 12.61, @sa.average_average_price_per_merchant
  end

  def test_get_individual_standard_deviation_price
    assert_equal 0.10, @sa.price_standard_deviation_for_merchant(1)
    assert_equal 35.32, @sa.price_standard_deviation_for_merchant(2)
  end

  def test_get_all_item_price_standard_deviation
    assert_equal 22.29, @sa.price_standard_deviation
  end

  def test_find_golden_items
    expected_item = @ir.find_by_name("A dead bird in a bag")
    assert_equal [expected_item], @sa.golden_items(1)
  end

  def test_average_items_per_merchant
    se = SalesEngine.new("empty")
    sa = SalesAnalyst.new(se)
    ir = se.item_repo
    mr = se.merchant_repo
    item_1_details = {
      :id => 20,
      :name => "A thing that you want",
      :merchant_id => 21
    }
    item_2_details = {
      :id =>22,
      :name => "A thing you sorta want",
      :merchant_id => 21
    }

    items = [item_1_details, item_2_details]
    merchant_1_details = {
      :name => "The awesome store",
      :id   => 21
    }
    merchant_2_details = {
      :name => "Trump Store of Fail",
      :id   => 666
    }
    merchants = [merchant_1_details, merchant_2_details]

    items.each do |item|
      ir.add(item)
    end
    merchants.each do |merchant|
      mr.add(merchant)
    end

    assert_equal 1, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    se = SalesEngine.new("empty")
    sa = SalesAnalyst.new(se)
    ir = se.item_repo
    mr = se.merchant_repo
    item_1_details = {
      :id => 20,
      :name => "A thing that you want",
      :merchant_id => 21
    }
    item_2_details = {
      :id =>22,
      :name => "A thing you sorta want",
      :merchant_id => 21
    }

    items = [item_1_details, item_2_details]
    merchant_1_details = {
      :name => "The awesome store",
      :id   => 21
    }
    merchant_2_details = {
      :name => "Trump Store of Fail",
      :id   => 666
    }
    merchants = [merchant_1_details, merchant_2_details]

    items.each do |item|
      ir.add(item)
    end
    merchants.each do |merchant|
      mr.add(merchant)
    end

    assert_equal 1.41, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    se = SalesEngine.new("empty")
    sa = SalesAnalyst.new(se)
    ir = se.item_repo
    mr = se.merchant_repo
    item_1_details = {
      :id => 20,
      :name => "A thing that you want",
      :merchant_id => 21
    }
    item_2_details = {
      :id =>22,
      :name => "A thing you sorta want",
      :merchant_id => 21
    }
    item_3_details = {
      :id => 24,
      :name => "A thing that you kind of want",
      :merchant_id => 21
    }
    item_4_details = {
      :id =>26,
      :name => "A thing you really want",
      :merchant_id => 21
    }
    items = [item_1_details, item_2_details, item_3_details, item_4_details]
    merchant_1_details = {
      :name => "The awesome store",
      :id   => 21
    }
    merchant_2_details = {
      :name => "Trump Store of Fail",
      :id   => 666
    }
    merchants = [merchant_1_details, merchant_2_details]

    items.each do |item|
      ir.add(item)
    end
    merchants.each do |merchant|
      mr.add(merchant)
    end

    assert_equal [], sa.merchants_with_high_item_count
  end

  def test_get_merchant_invoice_counts
    se = SalesEngine.from_csv({
      :merchants => './test/support/merchants_for_invoice_analysis.csv',
      :invoices => './test/support/invoice_for_analysis.csv'
    })
    sa = SalesAnalyst.new(se)
    invoice_counts = sa.get_merchant_invoice_counts(se.all_merchants)
    assert_equal [10,7,12,11,10,10,13], invoice_counts
  end

  def test_average_invoice_per_merchant
    se = SalesEngine.from_csv({
      :merchants => './test/support/merchants_for_invoice_analysis.csv',
      :invoices => './test/support/invoice_for_analysis.csv'
    })
    sa = SalesAnalyst.new(se)

    assert_equal 10.43, sa.average_invoices_per_merchant
  end

  def test_standard_dev_invoice_per_merchant
    se = SalesEngine.from_csv({
      :merchants => './test/support/merchants_for_invoice_analysis.csv',
      :invoices => './test/support/invoice_for_analysis.csv'
    })
    sa = SalesAnalyst.new(se)
    assert_equal 1.9, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    se = SalesEngine.from_csv({
      :merchants => './test/support/merchants_for_invoice_analysis.csv',
      :invoices => './test/support/invoice_for_analysis.csv'
    })
    sa = SalesAnalyst.new(se)
    assert_equal 12334135, sa.top_merchants_by_invoice_count(1).first.id
  end

  def test_bottom_merchants_by_invoice_count
    se = SalesEngine.from_csv({
      :merchants => './test/support/merchants_for_invoice_analysis.csv',
      :invoices => './test/support/invoice_for_analysis.csv'
    })
    sa = SalesAnalyst.new(se)
    assert_equal 12334112, sa.bottom_merchants_by_invoice_count(1).first.id
  end

  def test_invoice_status
    se = SalesEngine.from_csv({
      :merchants => './test/support/merchants_for_invoice_analysis.csv',
      :invoices => './test/support/invoice_for_analysis.csv'
    })
    sa = SalesAnalyst.new(se)
    assert_equal 23.29, sa.invoice_status(:pending)
    assert_equal 13.70, sa.invoice_status(:returned)
    assert_equal 63.01, sa.invoice_status(:shipped)
  end

  def test_group_invoices_by_day
    se = SalesEngine.from_csv({
      :merchants => './test/support/merchants_for_invoice_analysis.csv',
      :invoices => './test/support/invoice_for_analysis.csv'
    })
    sa = SalesAnalyst.new(se)
    expected_invoice_day_counts = [6, 15, 13, 8, 7, 7, 17]
    day_invoice_data = sa.group_invoices_by_day(se.all_invoices)
    expected_invoice_day_counts.each_with_index do |count, day|
      assert_equal count, day_invoice_data[day].count
    end
  end

  def test_avg_invoices_per_day
    se = SalesEngine.from_csv({
      :merchants => './test/support/merchants_for_invoice_analysis.csv',
      :invoices => './test/support/invoice_for_analysis.csv'
    })
    sa = SalesAnalyst.new(se)
    assert_equal 10.43, sa.average_invoices_per_day
  end

  def test_invoices_per_day_std
    se = SalesEngine.from_csv({
      :merchants => './test/support/merchants_for_invoice_analysis.csv',
      :invoices => './test/support/invoice_for_analysis.csv'
    })
    sa = SalesAnalyst.new(se)
    assert_equal 4.47, sa.average_invoices_per_day_std
  end

  def test_top_days_by_invoice_count
    se = SalesEngine.from_csv({
      :merchants => './test/support/merchants_for_invoice_analysis.csv',
      :invoices => './test/support/invoice_for_analysis.csv'
    })
    sa = SalesAnalyst.new(se)
    assert_equal ["Tuesday", "Thursday"], sa.top_days_by_invoice_count
  end

  def test_merchants_with_pending_invoices
    mock_se = Minitest::Mock.new
    mock_merchant_1 = Minitest::Mock.new
    mock_merchant_2 = Minitest::Mock.new
    mock_merchant_3 = Minitest::Mock.new
    mock_merchant_4 = Minitest::Mock.new
    mock_successful_invoice = Minitest::Mock.new
    mock_pending_invoice    = Minitest::Mock.new
    mock_failed_invoice     = Minitest::Mock.new
    sa = SalesAnalyst.new(mock_se)

    mock_merchants = [mock_merchant_1, mock_merchant_2, mock_merchant_3, mock_merchant_4]
    mock_se.expect(:all_merchants, mock_merchants)
    2.times do
      mock_successful_invoice.expect(:is_paid_in_full?, true)
    end
    mock_pending_invoice.expect(:is_paid_in_full?, false)
    mock_failed_invoice.expect(:is_paid_in_full?, false)
    mock_merchant_1.expect(:invoices, [mock_pending_invoice])
    mock_merchant_2.expect(:invoices, [mock_successful_invoice, mock_successful_invoice])
    mock_merchant_3.expect(:invoices, [])
    mock_merchant_4.expect(:invoices, [mock_failed_invoice, mock_pending_invoice] )

    assert_equal [mock_merchant_1, mock_merchant_4], sa.merchants_with_pending_invoices
    assert mock_merchant_1.verify
    assert mock_merchant_2.verify
    assert mock_merchant_3.verify
    assert mock_merchant_4.verify
    assert mock_successful_invoice.verify
    assert mock_pending_invoice.verify
    assert mock_failed_invoice.verify
    assert mock_se.verify
  end

  def test_merchants_with_only_one_item
    mock_se = Minitest::Mock.new
    mock_merchant_1 = Minitest::Mock.new
    mock_merchant_2 = Minitest::Mock.new
    mock_merchant_3 = Minitest::Mock.new
    sa = SalesAnalyst.new(mock_se)
    mock_merchants = [mock_merchant_1, mock_merchant_2, mock_merchant_3]
    mock_se.expect(:all_merchants, mock_merchants)
    mock_merchant_1.expect(:items, ["an item", "another item"])
    mock_merchant_2.expect(:items, ["just one item"])
    mock_merchant_3.expect(:items, [])
    assert_equal [mock_merchant_2], sa.merchants_with_only_one_item
    assert mock_se.verify
    assert mock_merchant_1.verify
    assert mock_merchant_2.verify
    assert mock_merchant_3.verify
  end

end
