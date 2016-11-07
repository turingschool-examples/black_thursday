require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test 

  attr_reader :engine, :analyst

  def setup
    @engine = SalesEngine.from_csv({:items => './data/items.csv', 
                                    :merchants => './data/merchants.csv', 
                                    :invoices => "./data/invoices.csv", 
                                    :invoice_items => "./data/invoice_items.csv",
                                    :transactions => "./data/transactions.csv",
                                    :customers => "./data/customers.csv"})
    @analyst =  SalesAnalyst.new(engine)
  end

  def test_engine_is_accessible_from_analyst
    assert_equal 475, analyst.engine.merchants.all.count
  end

  def test_analyst_returns_average_items_per_merchant
    assert_equal 2.88, analyst.average_items_per_merchant.round(2)
  end

  def test_analyst_returns_average_items_per_merchant_standard_deviation
    assert_equal 3.26, analyst.average_items_per_merchant_standard_deviation.round(2)
  end

  def test_that_stdev_method_works
    array = [13, 22, 23, 50]
    expected = 13.838352503098047
    assert_equal expected, analyst.stdev(array)
  end

  def test_it_averages_arrays
    array = [13, 22, 23, 50]
    assert_equal 27, analyst.find_average(array)
  end

  def test_it_returns_high_item_count
    expected_array = ["Keckenbauer : 25", "BowlsByChris : 7", "MotankiDarena : 7", "SassyStrangeArt : 10", "Lnjewelscreation : 7", "FlavienCouche : 20", "VectorCoast : 9", "ElisabettaComotto : 10", "2MAKERSMARKET : 9", "BLAISEPANDORA : 7", "IOleynikova : 10", "EndlessCirclesHoops : 7", "MyouBijou : 9", "DenesDoorDecor : 7", "CECALInterior : 8", "SusansWearableArt : 10", "CoastalCreations16 : 11", "RachelRonnieDesigns : 8", "Cashcollections : 9", "aperfectmessCandleCo : 14", "dvinebasketsbybrenda : 8", "Blankiesandfriends : 11", "metasstore : 10", "Dickensinkprintables : 12", "SimchaCentralShop : 9", "JamesCByrneART : 10", "ShopDixieChicken : 19", "Necklacemaniac : 17", "Quadrantes : 10", "HooknSpindle : 25", "9LivesJewelry : 8", "BoDaisyClothing : 8", "twistedupwraps : 11", "SHOPAMO : 7", "CrochetLoveMemories : 7", "RoyalwoodsStudio : 12", "AlchemyandRoot : 13", "SweetheartDarling : 8", "KatesPlot : 10", "ArgyllHandmadeGifts : 9", "IanLudiBoards : 8", "BodyTropics : 10", "IntlMilitaryAntiques : 12", "perfectbrooches : 13", "BandCCeramics : 7", "WickedlyGoodPotions : 10", "twosquaredblocks : 7", "safetygear : 14", "VintageCanvasPosters : 10", "CastrosCrafts : 8", "MarkThomasJewelry : 8", "JewelleAccessories : 10"]
    found_merchants = analyst.merchants_with_high_item_count.map { |merchant| "#{merchant.name} : #{merchant.items.count}"}
    assert_equal expected_array, found_merchants
  end

  def test_it_finds_average_price_of_one_merchant
    assert_equal 25.0, analyst.average_item_price_for_merchant(12334145).to_f
  end

  def test_analyst_finds_average_average_price_per_merchant
    assert_equal 350.29, analyst.average_average_price_per_merchant.to_f
  end

  def test_it_finds_golden_items_of_all_items
    golden_array = ["Test listing : 99999.0", "Original British Household Cavalry Named Life Guards Officer Cuirass and Helmet Set [ON8829] : 7495.0", "Original WWII Guinness Advertising Oil on Canvas Artwork by John Gilroy - 1944 Royal Navy Submarine Crew [ON8505] : 24995.0", "Original WWII Guinness Advertising Oil on Canvas Artwork by John Gilroy - 1944 Royal Air Force Bomber Crew [ON8500] : 24995.0", "Solid American Black Walnut Trestle Table : 7000.0"]
    found_items = analyst.golden_items.map { |item| "#{item.name} : #{item.unit_price_as_dollars}"}
    assert_equal golden_array, found_items
  end

  def test_analyst_finds_average_invoices_per_merchant
    assert_equal 10.49, analyst.average_invoices_per_merchant
  end

  def test_it_finds_stdev_of_average_invoices_per_merchant
    assert_equal 3.29, analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_analyst_returns_top_performing_merchants_two_stdevs_over_average
    top_merchants = ["jejum", "MotankiDarena", "thepurplepenshop", "handicraftcallery", "HoggardWoodworks", "GiveEmPropsStudio", "DressedInMusic", "shop20161", "Sewuniquedivas", "Chemisonodimenticato", "SmellyHippieSoaps", "DecadentCreationsbyJ"]
    found_merchants = analyst.top_merchants_by_invoice_count
    assert_equal top_merchants, found_merchants.map {|merchant| merchant.name}
  end

  def test_analyst_returns_bottom_performing_merchants_two_stdevs_under_average
    lowest_merchants = ["WellnessNeelsen", "CoastalCreations16", "TheLittleGlitter", "LoganNortonPhotos"]
    found_merchants = analyst.bottom_merchants_by_invoice_count
    assert_equal lowest_merchants, found_merchants.map {|merchant| merchant.name}
  end

  def test_it_find_top_days_for_sales
    assert_equal ['Wednesday'], analyst.top_days_by_invoice_count
  end

  def test_invoice_status_returns_percentage_with_status
    assert_equal 29.55, analyst.invoice_status(:pending)
  end

  def test_total_revnue_by_date
    assert_equal 13882.91, analyst.total_revenue_by_date(Time.parse("2004, feb, 25")).to_f
  end

  def test_find_top_revenue_merchants
    expected = 12334634
    result = analyst.top_revenue_earners(4).map {|merchant| merchant.id}
    assert_equal 4, result.count
    assert_equal expected, result.first
  end

  def test_find_top_merchants_returns_twenty_merchants_by_default
    assert_equal 20, analyst.top_revenue_earners.count
  end

  def test_it_finds_revenue_for_single_merchant
    assert_equal 155553.39, analyst.revenue_by_merchant(12335747).to_f
  end

  def test_returning_merchants_with_pending_invoices
    assert_equal 467, analyst.merchants_with_pending_invoices.count
  end

  def test_it_returns_merchants_with_one_item
    assert_equal 243, analyst.merchants_with_only_one_item.count
  end

  def test_findind_merchants_with_one_item_in_first_month
    assert_equal 18, analyst.merchants_with_only_one_item_registered_in_month("june").count
  end

  def test_merchants_ranked_by_revenue_returns_all_ranked_merchants
    result = analyst.merchants_ranked_by_revenue
    assert_equal 475, result.count
    assert_equal 12334634, result.first.id
    assert_equal 12336175, result.last.id
  end

  def test_finding_items_by_merchant
    desired_merchant = analyst.engine.merchants.find_by_id(12334395)
    assert_equal 5, desired_merchant.items.count
  end

  def test_finding_customers_by_merchant
    desired_merchant = analyst.engine.merchants.find_by_id(12334395)
    assert_equal 11, desired_merchant.customers.count
  end

  def test_finding_merchant_by_item
    desired_item = analyst.engine.items.find_by_id(263400233)
    assert_equal 12334423, desired_item.merchant.id
  end

  def test_finding_items_by_invoice
    desired_invoice = analyst.engine.invoices.find_by_id(18)
    assert_equal 7, desired_invoice.items.count
  end

  def test_finding_transactions_by_invoice
    desired_invoice = analyst.engine.invoices.find_by_id(18)
    assert_equal 2, desired_invoice.transactions.count
  end

  def test_finding_customer_by_invoice
    desired_invoice = analyst.engine.invoices.find_by_id(18)
    assert_equal 5, desired_invoice.customer.id
  end

  def test_invoice_is_paid_in_full
    desired_invoice = analyst.engine.invoices.find_by_id(18)
    assert_equal true, desired_invoice.is_paid_in_full?
  end

  def test_finding_merchants_by_customers
    desired_customer = analyst.engine.customers.find_by_id(5)
    assert_equal 8, desired_customer.merchants.count
  end

  def test_finding_invoice_by_transaction
    desired_transaction = analyst.engine.transactions.find_by_id(3)
    assert_equal 750, desired_transaction.invoice.id
  end
end
